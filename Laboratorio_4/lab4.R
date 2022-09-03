library(readr)
library(dplyr)
library(stringr)
df <- read.csv('tabla_completa.csv', sep = ',')
df1 <- read.csv('tabla_completa_v1.csv', sep = ',')
df1 <- select(df1, -X.1, -X.2, -X.3)

#Marcar faltantes
df <- df %>%
  mutate(faltante = case_when(
    grepl("faltante", tolower(df$CLIENTE)) ~ 1,
    
  ))
#Marcar despacho al cliente
df <- df %>%
  mutate(despacho_cliente = case_when(
    grepl("despacho a cliente",tolower(df$CLIENTE)) ~ 1
  ))
#Marcar devolucion
df <- df %>%
  mutate(devolucion = case_when(
    grepl("devolucion",tolower(df$CLIENTE)) ~ 1
  ))
df1 <- df1 %>% mutate(faltante = df$faltante)
df1 <- df1 %>% mutate(despacho_cliente = df$despacho_cliente)
df1 <- df1 %>% mutate(devolucion = df$devolucion)
df <- df1
df$CLIENTE <- iconv(df$CLIENTE, to = 'UTF-8')
df$CLIENTE <- str_remove_all(df$CLIENTE, " ")



#Ver cuentos faltantes hay 
df %>%
  select(faltante, despacho_cliente, devolucion) %>%
  filter(faltante == 1) %>%
  filter(is.na(despacho_cliente)) %>%
  filter(is.na(devolucion)) %>%
  summarise(faltantes = n())
#ver despacho a cliente
df %>%
  select(faltante, despacho_cliente, devolucion) %>%
  filter(despacho_cliente == 1) %>%
  filter(is.na(faltante)) %>%
  filter(is.na(devolucion)) %>%
  summarise(despacho_clientes = n())
#ver devolucion
df %>%
  select(faltante, despacho_cliente, devolucion) %>%
  filter(devolucion == 1) %>%
  filter(is.na(despacho_cliente)) %>%
  filter(is.na(faltante)) %>%
  summarise(devoluciones = n())



# Ver cuales son faltantes que fueron al despacho al cliente
df %>%
  select(faltante, despacho_cliente) %>%
  filter(faltante == 1) %>%
  filter(despacho_cliente == 1) %>%
  summarise(faltante_despacho_a_cliente = n())


# sin clasificacion/ extra
df %>%
  select(faltante, despacho_cliente, devolucion) %>%
  filter(is.na(faltante)) %>%
  filter(is.na(despacho_cliente)) %>%
  filter(is.na(devolucion)) %>%
  summarise(sincat = n())



# ver la cantidad de cada credito, teniendo un envio de faltante
df %>%
  select(CREDITO, faltante, despacho_cliente, devolucion) %>%
  filter(faltante == 1) %>%
  filter(is.na(despacho_cliente)) %>%
  filter(is.na(devolucion)) %>%
  group_by(CREDITO) %>%
  summarise(cant = n())
# Ver cuales son faltantes que fueron al despacho al cliente, con crédito
df %>%
  select(faltante, despacho_cliente, CREDITO) %>%
  filter(faltante == 1) %>%
  filter(despacho_cliente == 1) %>%
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
  select(UNIDAD, faltante, CANTIDAD, despacho_cliente, devolucion) %>%
  filter(faltante == 1) %>%
  filter(is.na(despacho_cliente)) %>%
  filter(is.na(devolucion)) %>%
  group_by(UNIDAD) %>%
  summarise(cant_viajes = n(),can_unidades = sum(CANTIDAD)) 

#CLIENTES VIAJES
df %>%
  select(CLIENTE) %>%
  group_by(CLIENTE) %>%
  summarise(pedidos = n()) %>%
  arrange(desc(pedidos))

#clientes con faltante
df %>%
  select(CLIENTE, faltante, despacho_cliente, devolucion) %>%
  filter(faltante == 1) %>%
  filter(is.na(despacho_cliente)) %>%
  filter(is.na(devolucion)) %>%
  group_by(CLIENTE) %>%
  summarise(pedidos = n(), faltantes = sum(faltante)) 



