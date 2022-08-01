#------------Excel------------------
##### cargar las librerias necesarias
library(readxl)
library(readr)
library(tidyverse)
library(tidytext)

excel <- readxl::read_excel('example_1.xlsx')
head(excel)
str(excel) #ver las columnas, sus tipo de datos y cantidad. 

excel_sheets('example_1.xlsx') # ver las hojas de excel que tenemos

#### seleccionar la hoja que queremos

excel_2 <- read_excel('example_1.xlsx', sheet = 2) ## puede ser el número o el nombre de la hoja

#exportaar el excel
write_excel_csv2(excel, "exportar_excel.xls", delim = ",")
#-------------CSV/TXT----------------
# separado por comas
csv <- read_csv("example_2.csv")
head(csv)

# separado por distinto parámetro que no sea coma. 
txt_1 <-read_delim('example_3.txt', delim = ";")
txt_2 <-read_delim('example_4.txt', delim = "|")

#------------librostxt---------------
  #ProjectGutenberg, sacar libross

dorian <- read_lines('dorian_gray.txt', skip_empty_rows = TRUE)

dorian[4] # agarro una linea

### de documentos de texto a data tabular

dorian_frame <- tibble(dorian)

dorian_words <- unnest_tokens(dorian_frame, output = word, input = dorian, token = "words")

dorian_words %>%
    select(word) %>%
    group_by(word) %>%
    count(word) %>%
    arrange(desc(n))
