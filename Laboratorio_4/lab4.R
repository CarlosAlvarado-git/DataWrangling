library(readr)
library(dplyr)
library(stringr)
df <- read.csv('tabla_completa.csv', sep = ',')


# Adding column based on other column:
#Marcar faltantes
df <- df %>%
  mutate(Faltante = case_when(
    grepl("faltante", tolower(df$CLIENTE)) ~ 1,
    
  ))
#Marcar despacho al cliente
df <- df %>%
  mutate(despacho_cliente = case_when(
    grepl("despacho a cliente",tolower(df$CLIENTE)) ~ 2
  ))
#Marcar devolucion
df <- df %>%
  mutate(devolucion = case_when(
    grepl("devolucion",tolower(df$CLIENTE)) ~ 3
  ))



#Ver cuentos faltantes hay 
df %>%
  select(Faltante) %>%
  filter(Faltante == 1) %>%
  summarise(n = n())
#ver despacho a cliente
df %>%
  select(despacho_cliente) %>%
  filter(despacho_cliente == 2) %>%
  summarise(n = n())
#ver devolucion
df %>%
  select(devolucion) %>%
  filter(devolucion == 3) %>%
  summarise(n = n())
# Ver cuales son faltantes que fueron al despacho al cliente
df %>%
  select(Faltante, despacho_cliente) %>%
  filter(Faltante == 1) %>%
  filter(despacho_cliente == 2) %>%
  summarise(faltante_despacho_a_cliente = n())
# Ver cuales son faltantes que fueron al despacho al cliente y devolucion
df %>%
  select(Faltante, despacho_cliente, devolucion) %>%
  filter(Faltante == 1) %>%
  filter(despacho_cliente == 2) %>%
  filter(devolucion == 3) %>%
  summarise(fal_despa_devolu = n())
# sin clasificacion/ extra
df %>%
  select(Faltante, despacho_cliente, devolucion) %>%
  filter(is.na(Faltante)) %>%
  filter(is.na(despacho_cliente)) %>%
  filter(is.na(devolucion)) %>%
  summarise(sincat = n())


# ver la cantidad de cada credito, teniendo un envio de faltante
df %>%
  select(CREDITO, Faltante) %>%
  filter(Faltante == 1) %>%
  group_by(CREDITO) %>%
  summarise(cant = n())
# Ver cuales son faltantes que fueron al despacho al cliente
df %>%
  select(Faltante, despacho_cliente, CREDITO) %>%
  filter(Faltante == 1) %>%
  filter(despacho_cliente == 2) %>%
  group_by(CREDITO) %>%
  summarise(cant = n())
#Viajes por mes
df %>%
  select(MES) %>%
  group_by(MES) %>%
  summarise(cant = n())

#Cuentos pilotos tienes
df %>%
  select(PILOTO) %>%
  summarise(cant = n_distinct(PILOTO))


#Transporte con faltante
df %>%
  select(UNIDAD, Faltante) %>%
  filter(Faltante == 1) %>%
  group_by(UNIDAD) %>%
  summarise(cant = n())
