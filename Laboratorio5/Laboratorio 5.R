# Carlos Manuel Alvarado Andrade

## Parte 1: Predecir un eclipse solar

# En tiempo de Norte América, el eclipse total inició el 21 de agosto del 2017 a las 18:26:40.

# Este mismo evento, sucederá un Saros después.
# Un Saros equivale a 223 Synodic Months
# Un Synodic Month equivale a 29 días con 12 horas, con 44 minutos y 3 segundos.
library(lubridate)
library(readxl)
library(stringr)
library(dplyr)
dia_SM <- 29
horas_SM <- 12
minutos_SM <- 44
segs_SM <- 3

SynodicMonth <- days(dia_SM) + hours(horas_SM) + minutes(minutos_SM) + seconds(segs_SM)
Saros <- 223 * SynodicMonth

Dia_eclipse <- ymd_hms("2017-08-21 18:26:40")
Dia_eclipse

Fecha_final <- Dia_eclipse + Saros
Fecha_final

## Parte 2: Agrupaciones y operaciones con fechas

data <- readxl::read_xlsx("data.xlsx")
#Para las fechas Creación
fechas_num <- data
fechas_dis <- data
fechas_num$`Fecha Creación` <- format((as_date(as.numeric(fechas_num$`Fecha Creación`), origin = dmy("30/12/1899"))), "%d-%m-%Y")
fechas_num$`Fecha Creación` <- dmy(fechas_num$`Fecha Creación`)

fechas_dis$`Fecha Creación` <- dmy(fechas_dis$`Fecha Creación`)

fechas_dis <- fechas_dis[!is.na(fechas_dis$`Fecha Creación`),]

fechas_num <- fechas_num[!is.na(fechas_num$`Fecha Creación`),]

data <- bind_rows(fechas_dis, fechas_num)

#Para las fechas final
fechas_num <- data
fechas_dis <- data
fechas_num$`Fecha Final` <- format((as_date(as.numeric(fechas_num$`Fecha Final`), origin = dmy("30/12/1899"))), "%d-%m-%Y")
fechas_num$`Fecha Final` <- dmy(fechas_num$`Fecha Final`)

fechas_dis$`Fecha Final` <- dmy(fechas_dis$`Fecha Final`)

fechas_dis <- fechas_dis[!is.na(fechas_dis$`Fecha Final`),]

fechas_num <- fechas_num[!is.na(fechas_num$`Fecha Final`),]
data <- bind_rows(fechas_dis, fechas_num)

# 1.	¿En qué meses existe una mayor cantidad de llamadas por código? agrupar por mes y código. summarize = n()
# 2.	¿Qué día de la semana es el más ocupado? agrupar por weekdays, summarize
# 3.	¿Qué mes es el más ocupado? - agrupar por mes, summarize
# 4.	¿Existe una concentración o estacionalidad en la cantidad de llamadas? - lo mismo del mes, solo que dias
# 5.	¿Cuántos minutos dura la llamada promedio? 14.algo. mean(difftime(horafinal, horainicio, unit = minutos))
# 6.	Realice una tabla de frecuencias con el tiempo de llamada. mutatua o grafica del difftime

  
  
  