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
  tickfont = list(color = "red"),
  overlaying = "y",
  side = "right",
  title = "Costo promedio por servicio"
)
ay2 <- list(
  tickfont = list(color = "green"),
  overlaying = "y",
  side = "right",
  title = "Margen promedio por servicio"
)
ay3 <- list(
  tickfont = list(color = "black"),
  overlaying = "y",
  side = "right",
  title = "Factura promedio por servicio"
)
inv4 <- data %>%
  select(Fecha,Cod,marge_venta) %>%
  filter(Fecha %within% interval(ymd("2017-01-01"), ymd("2017-10-01"))) %>%
  group_by(Cod) %>%
  summarise(cantidad = n())
inv5 <- data %>%
  select(Fecha, Cod,costos) %>%
  filter(Fecha %within% interval(ymd("2017-01-01"), ymd("2017-10-01"))) %>%
  group_by(Cod) %>%
  summarise(costos = mean(costos))
inv6 <- data %>%
  select(Fecha, Cod,marge_venta_porcostos) %>%
  filter(Fecha %within% interval(ymd("2017-01-01"), ymd("2017-10-01"))) %>%
  group_by(Cod) %>%
  summarise(marge_venta_porcostos = mean(marge_venta_porcostos))
inv7 <- data %>%
  select(Fecha, Cod,factura) %>%
  filter(Fecha %within% interval(ymd("2017-01-01"), ymd("2017-10-01"))) %>%
  group_by(Cod) %>%
  summarise(factura = mean(factura))


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
    y=~inv5$costos,
    type="scatter",
    mode="lines+markers",
    name="costo promedio",
    yaxis="y2"
  ) %>%
  add_trace(
    data=inv6,
    x=~inv6$Cod,
    y=~inv6$marge_venta_porcostos,
    type="scatter",
    mode="lines+markers",
    name="margen promedio",
    yaxis="y2"
  ) %>%
  add_trace(
    data=inv7,
    x=~inv7$Cod,
    y=~inv7$factura,
    type="scatter",
    mode="lines+markers",
    name="factura promedio",
    yaxis="y2"
  ) %>%
  layout(yaxis = list(title = 'Viajes'), 
         yaxis2 = ay,
         yaxis3 = ay2,
         yaxis4 = ay3)
#### Correlación entre las variables
# ver p valor 
base <- data %>%
  filter(Fecha %within% interval(ymd("2017-01-01"), ymd("2017-10-01"))) %>%
  select(factura, marge_venta_porcostos,fijoCamion_5, fijoPickup, fijoMoto, `5-30`, `30-45`, `45-75`, `75-120`, `120+`)
  
rcorr(as.matrix(base))
# la onda del p valor, todos 0. Estadístico significativo.
## grafica de correlación
correlacion<-round(cor(base), 1)

corrplot(correlacion, method="number", type="upper")
#### servicios con camion, moto, pickup
data %>%
  select(Cod,Camion_5, Fecha) %>%
  filter(Camion_5 > 0) %>%
  filter(Fecha %within% interval(ymd("2017-01-01"), ymd("2017-10-01"))) %>%
  group_by(Cod) %>%
  summarise(viajes_camion = n()) %>%
  arrange()
data %>%
  select(Cod,Pickup, Fecha) %>%
  filter(Pickup > 0) %>%
  filter(Fecha %within% interval(ymd("2017-01-01"), ymd("2017-10-01"))) %>%
  group_by(Cod) %>%
  summarise(viajes_pickup = n())%>%
  arrange()
data %>%
  select(Cod,Moto, Fecha) %>%
  filter(Moto > 0) %>%
  filter(Fecha %within% interval(ymd("2017-01-01"), ymd("2017-10-01"))) %>%
  group_by(Cod) %>%
  summarise(viajes_moto = n())%>%
  arrange()


### Codigo maximo, media y minimo de margen operativo
data %>%
  select(Fecha, Cod, marge_venta_porcostos) %>%
  filter(Fecha %within% interval(ymd("2017-01-01"), ymd("2017-10-01"))) %>%
  group_by(Cod) %>%
  summarise(minimo = min(marge_venta_porcostos), media = mean(marge_venta_porcostos), maximo = max(marge_venta_porcostos))

quantile(data$marge_venta_porcostos)

### Codigo maximo, media y minimo de costos fijos por camiono
data %>%
  select(Fecha, Cod, fijoCamion_5) %>%
  filter(Fecha %within% interval(ymd("2017-01-01"), ymd("2017-10-01"))) %>%
  group_by(Cod) %>%
  summarise(minimo = min(fijoCamion_5), media = mean(fijoCamion_5), maximo = max(fijoCamion_5))
fijocamion <- data %>%
  select(Fecha,directoMoto) %>%
           filter(Fecha %within% interval(ymd("2017-01-01"), ymd("2017-10-01"))) %>%
           filter(directoMoto > 0)

quantile(fijocamion$fijoMoto)
mean(fijocamion$fijoMoto)
min(fijocamion$fijoMoto)
max(fijocamion$fijoMoto)

directocamion <- data %>%
  select(Fecha,costos) %>%
  filter(Fecha %within% interval(ymd("2017-01-01"), ymd("2017-09-30"))) %>%
  filter(costos > 0)

quantile(directocamion$costos)
mean(directocamion$costos)
min(directocamion$costos)
max(directocamion$costos)

## facturas

quantile(data$factura)

#### servicios al mes

viajes_mes <- data %>%
  select(Fecha, Cod) %>%
  filter(Fecha %within% interval(ymd("2017-01-01"), ymd("2017-09-30"))) %>%
  group_by(month(Fecha), Cod) %>% 
  summarise(cantidad_de_servicio = n())
library(ggplot2)
ggplot(viajes_mes, aes(fill=`month(Fecha)`, y = viajes_mes$Cod, x = viajes_mes$cantidad_de_servicio)) +
  geom_bar(position="stack", stat="identity") +
  xlab("Cantidad de viajes") +
  ylab("Codigo de servicio") +
  ggtitle("Cantidad de servicios realizados al mes")






write.csv(viajes_mes, "viajes.csv", row.names = FALSE)
data <- data %>%
        mutate(costos = (Camion_5 + Pickup + Moto))

postes_analisis <- data %>%
  filter(Fecha %within% interval(ymd("2017-01-01"), ymd("2017-09-30"))) %>%
  filter(Cod == "OTRO") %>%
  select(ID, marge_venta_porcostos, factura, costos) %>%
  group_by(ID) %>%
  summarise(viajes = n(), 
            margen_tota = sum(marge_venta_porcostos),
            margen_promedio = mean(marge_venta_porcostos),
            factura_total = sum(factura),
            factura_promedio = mean(factura),
            costos_total = sum(costos),
            costos_promedio = mean(costos)) %>%
  arrange(desc(viajes)) %>%
  Filter()



quantile(postes_analisis$viajes)

  
data %>%
  select(Fecha,Cod,factura, costos, marge_venta_porcostos) %>%
  filter(Fecha %within% interval(ymd("2017-01-01"), ymd("2017-10-01"))) %>%
  group_by(Cod) %>%
  summarise(viajes = n(), 
            margen_total = sum(marge_venta_porcostos),
            factura_total = sum(factura),
            costos_total = sum(costos),
            margen_promedio = mean(marge_venta_porcostos)) %>%
  arrange(desc(margen_total))  

ids <- unique(data$ID)
length()


a <- data %>%
  filter(directoCamion_5 == 0.58)
