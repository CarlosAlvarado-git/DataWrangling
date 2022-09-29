# Carlos Manuel Alvarado Andrade

## Parte 1: Predecir un eclipse solar

# En tiempo de Norte América, el eclipse total inició el 21 de agosto del 2017 a las 18:26:40.

# Este mismo evento, sucederá un Saros después.
# Un Saros equivale a 223 Synodic Months
# Un Synodic Month equivale a 29 días con 12 horas, con 44 minutos y 3 segundos.
library(lubridate)
library(readxl)
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
primero <- (as_date(as.numeric(data[1,1]), origin = dmy("30/12/1899")))
day(primero)
as.Date.numeric(43020, origin = dmy("30/12/1899"))
# 1.	¿En qué meses existe una mayor cantidad de llamadas por código?


# 2.	¿Qué día de la semana es el más ocupado?
# 3.	¿Qué mes es el más ocupado?
# 4.	¿Existe una concentración o estacionalidad en la cantidad de llamadas?
# 5.	¿Cuántos minutos dura la llamada promedio?
# 6.	Realice una tabla de frecuencias con el tiempo de llamada.

  
  
  