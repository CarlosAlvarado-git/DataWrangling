library(readr)
library(dplyr)
library(lubridate)
library(highcharter)
library(ggplot2)
library(GGally)
library(Hmisc)
library(corrplot)
library(PerformanceAnalytics)
require(plotly)
data <- read_csv("c1.csv")
data <- data[,c(-23,-24,-25,-26,-27,-28)]
#data[,3] <- as.numeric(data[,3])

#---- limpiar data
data <- data %>%
          mutate(Camion_5 = gsub("Q", "", Camion_5),
                 Camion_5 = gsub("-", "0", Camion_5),
                 Camion_5 = as.numeric(Camion_5),
                 Pickup = gsub("Q", "", Pickup),
                 Pickup = gsub("-", "0", Pickup),
                 Pickup = as.numeric(Pickup),
                 Moto = gsub("Q", "", Moto),
                 Moto = gsub("-", "0", Moto),
                 Moto = as.numeric(Moto))
data <- data %>%
  mutate(directoCamion_5 = gsub("Q", "", directoCamion_5),
         directoCamion_5 = gsub("-", "0", directoCamion_5),
         directoCamion_5 = as.numeric(directoCamion_5))
data <- data %>%
  mutate(directoPickup = gsub("Q", "", directoPickup),
         directoPickup = gsub("-", "0", directoPickup),
         directoPickup = as.numeric(directoPickup))
data <- data %>%
  mutate(directoMoto = gsub("Q", "", directoMoto),
         directoMoto = gsub("-", "0", directoMoto),
         directoMoto = as.numeric(directoMoto))

data <- data %>%
  mutate(fijoCamion_5 = gsub("Q", "", fijoCamion_5),
         fijoCamion_5 = gsub("-", "0", fijoCamion_5),
         fijoCamion_5 = as.numeric(fijoCamion_5),
         fijoPickup = gsub("Q", "", fijoPickup),
         fijoPickup = gsub("-", "0", fijoPickup),
         fijoPickup = as.numeric(fijoPickup),
         fijoMoto = gsub("Q", "", fijoMoto),
         fijoMoto = gsub("-", "0", fijoMoto),
         fijoMoto = as.numeric(fijoMoto))
data <- data %>%
  mutate(Fecha = dmy(Fecha))
data <- data %>%
  mutate(factura = gsub("Q", "", factura),
         factura = gsub("-", "0", factura),
         factura = as.numeric(factura))
data[is.na(data)] <- "0"
data <- data %>%
        mutate(`5-30` = gsub("x", "1", `5-30`),
               `5-30` = as.numeric(`5-30`),
               `30-45` = gsub("x", "1", `30-45`),
               `30-45` = as.numeric(`30-45`),
               `45-75` = gsub("x", "1", `45-75`),
               `45-75` = as.numeric(`45-75`),
               `75-120` = gsub("x", "1", `75-120`),
               `75-120` = as.numeric(`75-120`),
               `120+` = gsub("x", "1", `120+`),
               `120+` = as.numeric(`120+`))

#### Estudiar los servicios.
data <- data %>%
      mutate(marge_venta = (factura - (Camion_5 + Pickup + Moto)))
data <- data %>%
  mutate(marge_venta_porcostos = (factura - (fijoCamion_5 + directoCamion_5+ fijoPickup +directoPickup+ fijoMoto+ directoMoto)))
ay <- list(
  tickfont = list(color = "orange"),
  overlaying = "y",
  side = "right",
  title = "Margen operativo"
)
inv4 <- data %>%
  select(Cod,marge_venta) %>%
  group_by(Cod) %>%
  summarise(cantidad = n())
inv5 <- data %>%
  select(Cod,marge_venta) %>%
  group_by(Cod) %>%
  summarise(margen_venta = mean(marge_venta))

plot_ly(
  data=inv4,
  x=~Cod,
  y=~cantidad,
  type="bar",
  name="Servicios por codigo"
) %>%
  add_trace(
    data=inv5,
    x=~inv5$Cod,
    y=~inv5$margen_venta,
    type="scatter",
    mode="lines+markers",
    name="Margen operativo promedio",
    yaxis="y2"
  ) %>%
  layout(yaxis = list(title = 'Viajes'), 
         yaxis2 = ay)
#### Correlación entre las variables
# ver p valor 
base <- data %>%
  select(directoCamion_5, directoPickup, directoMoto, fijoCamion_5, fijoPickup, fijoMoto, `5-30`, `30-45`, `45-75`, `75-120`, `120+`)
rcorr(as.matrix(base))
# la onda del p valor, todos 0. Estadístico significativo.
## grafica de correlación
correlacion<-round(cor(base), 1)

corrplot(correlacion, method="number", type="upper")


