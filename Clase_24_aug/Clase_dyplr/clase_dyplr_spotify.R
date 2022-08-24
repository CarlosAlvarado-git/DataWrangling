library(readr)
library(tidyverse)
library(highcharter)
csv <- read_delim("docclase.csv", ";", escape_double = FALSE)
### 
str(csv)
glimpse(csv)
### cambio de nombre de columna

names(csv)[4] <- "top_genre"
str(csv)
###tidy
csv <- rename(csv, top_genre = `top genre`)
str(csv)
names(csv)

### columnas de artista y año, con los primeros 5 datos. 
head(select(csv, artist, year))

#### usando %>% para remplazar las funciones anidades.
csv %>%
  select(artist, year) %>%
  filter(year == 2012) %>% 
  head()
### remplazar algo con un set de datos, con varias columnas
csv <- rename_with(csv, ~(gsub(" ", "_", .x)))

### base de r
csv[1,2]
csv[c(1,2)]
csv %>% select(1,2)
### eliminar una columna
csv[-1]
csv %>% select(-1) %>%
  head()

### mutate, para trasformar la variable

csv <- mutate_if(csv, is.character, as.factor)
str(csv)

## filtradndo 

csv %>%
  select(artist, year) %>%
  filter(year == 2012 | year == 2014)

### cuantos artistas tenemos por año

csv %>%
  select(year, artist) %>%
  group_by(year) %>%
  summarise(artist = n()) ### para conteo

### cuantos artistas tenemos en el dataset
  csv %>%
    summarise(artist = n_distinct(artist))
### el correcto
  csv %>%
    select(year, artist) %>%
    group_by(year) %>%
    summarise(artist = n_distinct(artist)) 
### canciones distintas en general
  csv %>%
    summarise(canciones = n_distinct(title))
  
### ver cuales se repiten
  csv %>%
    group_by(title) %>%
    summarise(conteo_canciones = n()) %>%
    filter(conteo_canciones > 1) %>%
    arrange(desc(conteo_canciones))

### como lo hizo tepi
  csv %>%
    group_by(title) %>%
    summarise(repeticiones = n()) %>%
    group_by(repeticiones) %>%
    summarise(cantidad_de_canciones = n())
  