library(readr)
library(tidyverse)
library(highcharter) #graficas
library(plotly) #graficas
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
    arrange(desc(conteo_canciones)) #es el limit

### como lo hizo tepi
  csv %>%
    group_by(title) %>%
    summarise(repeticiones = n()) %>%
    group_by(repeticiones) %>%
    summarise(cantidad_de_canciones = n())
  

  
##### clase de agosto 29 
df <- read_delim("docclase.csv", ";", escape_double = FALSE, trim_ws = TRUE)

df <- mutate(df, is.character, as.factor)
df$title <- iconv(df$title, to = "UTF-8")
df$artist <- iconv(df$artist, to = 'UTF-8')

df %>%
  select(year, artist) %>%
  group_by(year) %>%
  summarise(n = n_distinct(artist)) %>%
  hchart("column", hcaes(x = year, y = n)) %>% #hcaes es el set up de la grafica. 
  hc_title(text = "<b>Artistas distintos por año </b>") %>%
  hc_subtitle(text = "<i>2019 tuvo la menor variedad, mientras 2015 ha sifo con más diversidad de artistas </i>")

#Top 5 artistas con mayor cantidad de canciones populares


df %>%
  select(artist, title) %>%
  group_by(artist) %>%
  summarise(n = n_distinct(title)) %>%
  filter(n > 13) %>%
  arrange(desc(n)) %>%
  hchart("bar", hcaes(x = artist, y = n)) %>%
  hc_title(text = "<b>Top 5 artistas con mayor cantidad de canciones populares </b>") %>%
  hc_subtitle(text = "<i>Katy Perry tiene el mayor número de canciones populares. 
              Justin Bieber, Lady Gaga y Maroon5 son top 3 con 14</i>")

  