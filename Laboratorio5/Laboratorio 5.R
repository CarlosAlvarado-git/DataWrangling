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
library(tidyverse)
library(highcharter)
library(nycflights13)
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
data %>%
  group_by(month(`Fecha Creación`), Cod) %>%
  summarize(n = n())
# 2.	¿Qué día de la semana es el más ocupado? agrupar por weekdays, summarize
data %>%
  group_by(weekdays(`Fecha Creación`)) %>%
  summarise(total = n()) %>%
  arrange(desc(total))
# 3.	¿Qué mes es el más ocupado? - agrupar por mes, summarize
data %>%
  group_by(month(`Fecha Creación`)) %>%
  summarize(n = n()) %>%
  arrange(desc(n))
# 4.	¿Existe una concentración o estacionalidad en la cantidad de llamadas? - lo mismo del mes, solo que dias
data %>%
  group_by(day(`Fecha Creación`)) %>%
  summarize(n = n()) %>% 
  hchart("column", hcaes(x = `day(\`Fecha Creación\`)`, y = n)) %>% #hcaes es el set up de la grafica. 
  hc_title(text = "<b> Estacionalidad dias</b>") %>%
  hc_subtitle(text = "<i> Parece ser que el mes se mantiene constante, excepto los últimos 3 días del mes </i>")

# 5.	¿Cuántos minutos dura la llamada promedio? 14.algo. mean(difftime(horafinal, horainicio, unit = minutos))
(mean(difftime(data$`Hora Final`, data$`Hora Creación`, units = 'mins')))

# 6.	Realice una tabla de frecuencias con el tiempo de llamada. mutatua o grafica del difftime
data$duration <- difftime(data$`Hora Final`, data$`Hora Creación`, units = 'mins') 
data %>%
    select(`Fecha Creación`, duration) %>%
    group_by(day(`Fecha Creación`)) %>%
    summarise(n = mean(duration)) %>%
    hchart("column", hcaes(x = `day(\`Fecha Creación\`)`, y = n)) %>% #hcaes es el set up de la grafica. 
    hc_title(text = "<b> Tiempo promedio por dias </b>") 
data %>%
  group_by(duration) %>%
  summarise(n = n()) %>%
  hchart("column", hcaes(x = duration, y = n)) %>% #hcaes es el set up de la grafica. 
  hc_title(text = "<b> Dias con tiempos de llamadas </b>") 

data %>%
  group_by(duration) %>%
  

# Parte 3: Signo Zodiacal
#Realice una función que reciba como input su fecha de nacimiento y devuelva como output su signo zodiacal.

signo <- function(fecha) {
  if (day(fecha) <= 18 && month(fecha) == 1){
    fecha <- fecha + years(x=1)
  }
  Capricornio <- interval(ymd("2017-01-19"), ymd("2017-02-15"))
  Acuario <- interval(ymd("2017-02-16"), ymd("2017-03-11"))
  Piscis <- interval(ymd("2017-03-12"), ymd("2017-04-18"))
  Aries <- interval(ymd("2017-04-19"), ymd("2017-05-13"))
  Tauro <- interval(ymd("2017-05-14"), ymd("2017-06-19"))
  Geminis <- interval(ymd("2017-06-20"), ymd("2017-07-20"))
  Cancer <-interval(ymd("2017-07-21"), ymd("2017-08-09"))
  Leo <- interval(ymd("2017-08-10"), ymd("2017-09-15"))
  Virgo <- interval(ymd("2017-09-16"), ymd("2017-10-30"))
  Libra <- interval(ymd("2017-10-31"), ymd("2017-11-22"))
  Escorpio <- interval(ymd("2017-11-23"), ymd("2017-11-29"))
  Ofiuco <- interval(ymd("2017-11-30"), ymd("2017-12-17"))
  Sagitario <- interval(ymd("2017-12-18"), ymd("2018-01-18"))
  if (fecha %within% Capricornio){
    return("Capricornio")
  }
  if (fecha %within% Acuario){
    return("Acuario")
  }
  if (fecha %within% Piscis){
    return("Piscis")
  }
  if (fecha %within% Aries){
    return("Aries")
  }
  if (fecha %within% Tauro){
    return("Tauro")
  }
  if (fecha %within% Geminis){
    return("Géminis")
  }
  if (fecha %within% Cancer){
    return("Cáncer")
  }
  if (fecha %within% Leo){
    return("Leo")
  }
  if (fecha %within% Virgo){
    return("Virgo")
  }
  if (fecha %within% Libra){
    return("Libra")
  }
  if (fecha %within% Escorpio){
    return("Escorpio")
  }
  if (fecha %within% Ofiuco){
    return("Ofiuco")
  }
  if (fecha %within% Sagitario){
    return("Sagitario")
  }
}

#2017 como base
valor <- signo(ymd("2017-09-29"))
(valor)

# ●	Parte 4: Flights
# 1.	Genere 4 nuevas columnas para cada variable con formato fecha y hora.
vuelos <- flights
# La idea es hacer una división e ir obteniendo los residuos, para tener las horas, minutos, etc.
# la función floor, es lo que aproxima el valor resultante de las diviciones. 
# dep_time 
vuelos <- vuelos %>%
  filter(!is.na(dep_time)) %>%
  mutate(dep_time_final = (ymd_hm(paste(year,month,day,paste(floor(dep_time/100),":",round((dep_time/100-floor(dep_time/100))*100,digits=0), sep=""),sep=" "))))
# arr_time
vuelos <- vuelos %>%
  filter(!is.na(arr_time)) %>%
  mutate(arr_time_final = (ymd_hm(paste(year,month,day,paste(floor(arr_time/100),":",round((arr_time/100-floor(arr_time/100))*100,digits=0), sep=""),sep=" "))))
#sched_dep_time
vuelos <- vuelos %>%
  filter(!is.na(sched_dep_time)) %>%
  mutate(sched_dep_time_final = (ymd_hm(paste(year,month,day,paste(floor(sched_dep_time/100),":",round((sched_dep_time/100-floor(sched_dep_time/100))*100,digits=0), sep=""),sep=" "))))
#sched_arr_time
vuelos <- vuelos %>%
  filter(!is.na(sched_arr_time)) %>%
  mutate(sched_arr_time_final = (ymd_hm(paste(year,month,day,paste(floor(sched_arr_time/100),":",round((sched_arr_time/100-floor(sched_arr_time/100))*100,digits=0), sep=""),sep=" "))))

# 2.	Encuentre el delay total que existe en cada vuelo. El delay total se puede encontrar sumando el delay de la salida y el delay de la entrada.
# dep_time_final hora que realmente salio 
# arr_time_final hora que realmente llego
# sched_dep_time_final hora que tenian planeado salir
# sched_arr_time_final hora que tenian planeado llegar 
-----
  #Encuentre el delay total que existe en cada vuelo:
vuelos <- vuelos %>%
        mutate(delay_salida = difftime(dep_time_final, sched_dep_time_final, units = "mins"))
vuelos <- vuelos %>%
  mutate(delay_llegada = difftime(arr_time_final, sched_arr_time_final, units = "mins"))
# El delay total se puede encontrar sumando el delay de la salida y el delay de la entrada.

vuelos <- vuelos %>%
          mutate(delay_total = delay_salida + delay_llegada)
  