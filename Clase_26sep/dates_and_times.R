library(lubridate)
library(nycflights13)
library(tidyverse)

###### el dia de hoy
today()
##### base r
Sys.time()
###
now()

#### parsear fechas de textos
#parsear x
x <- "1994 October 27th"
ymd(x) #lo parsea a yyyy-mm-dd

y <- "27.10.1994"
dmy(y)
 
##### parser timedates
z <- "oct, 27th 1994 14:00"
mdy_hm(z)

#### diferencias de tiempo

date_landing <- mdy("July 20, 1969")
moment_step <- mdy_hms("July 20, 1969, 02:56:15", tz = "UTC")

##### cuantos dias desde el primer hombre en la luna
difftime(today(), date_landing, units = "hours")

#### suma timepos

mon_1pm <- dmy_hm("26 Sep 2022 13:00")
mon_1pm + weeks(x=1)

#### consideraciones de lubridate
#dos tipos de ondas temporales

## duratios: Mide la cantidad exacta entre dos momentos (Cronometro)
## periods: Interpretacion humana del tiempo

#### 2020
feb <- dmy("28 feb 2020")
feb + years(x=1)
feb + dyears(x=1)

jan <- dmy("31 jan 2022")
jan + years(x=1)

#### 
add_with_rollback(jan, months(x=1), roll_to_first = TRUE)
add_with_rollback(jan, months(x=1), roll_to_first = FALSE)


#### secuancias de fechas
jan <- dmy("31 jan 2022")
month_seq <- 1:12*months(1)
month_seq + jan
oct <- dmy("31 oct 2022")
seq(jan, oct, "weeks")


####nycflights13
flights %>%
  select(year, month, day, hour, minute, arr_time) %>%
  View()

flights %>% View()

make_date(year = 1995, month = 11, day = 21)

flights <- flights %>%
  mutate(departure = make_datetime(year = year, month = month, day = day, hour = hour, minute = minute))

####
day(flights$departure)
month(flights$departure, label = TRUE)
year(flights$departure)