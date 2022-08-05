Laboratorio_1
================
Carlos_Alvarado
2022-08-03

### Librerias

``` r
knitr::opts_chunk$set(echo = TRUE)
library(readxl)
library(readr)
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
    ## ✔ ggplot2 3.3.6     ✔ dplyr   1.0.9
    ## ✔ tibble  3.1.8     ✔ stringr 1.4.0
    ## ✔ tidyr   1.2.0     ✔ forcats 0.5.1
    ## ✔ purrr   0.3.4     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
library(tidytext)
library(tibble)
```

### PARTE 1

### Leer los xlsx

``` r
excel01 <- readxl::read_excel('01-2018.xlsx')
excel02 <- readxl::read_excel('02-2018.xlsx')
excel03 <- readxl::read_excel('03-2018.xlsx')
excel04 <- readxl::read_excel('04-2018.xlsx')
excel05 <- readxl::read_excel('05-2018.xlsx')
excel06 <- readxl::read_excel('06-2018.xlsx')
excel07 <- readxl::read_excel('07-2018.xlsx')
excel08 <- readxl::read_excel('08-2018.xlsx')
```

    ## New names:
    ## • `` -> `...10`

``` r
excel09 <- readxl::read_excel('09-2018.xlsx')
excel10 <- readxl::read_excel('10-2018.xlsx')
excel11 <- readxl::read_excel('11-2018.xlsx')
```

### Agregando la columna de FECHA

``` r
# necesito: FECHA, COD_VIAJE, CLIENTE, UBICACIÓN, CANTIDAD, PILOTO, Q, CREDITO, UNIDAD

#add_column(dataset, "Primera" = 4:8, .before = 1)
a1 <- as.numeric(nrow(excel01))
fecha_ = "01-2018"
FECHA <- rep(fecha_, a1)
excel01 <- add_column(excel01, FECHA, .before = 1)

a1 <- as.numeric(nrow(excel02))
fecha_ = "02-2018"
FECHA <- rep(fecha_, a1)
excel02 <- add_column(excel02, FECHA, .before = 1)

a1 <- as.numeric(nrow(excel03))
fecha_ = "03-2018"
FECHA <- rep(fecha_, a1)
excel03 <- add_column(excel03, FECHA, .before = 1)

a1 <- as.numeric(nrow(excel04))
fecha_ = "04-2018"
FECHA <- rep(fecha_, a1)
excel04 <- add_column(excel04, FECHA, .before = 1)

a1 <- as.numeric(nrow(excel05))
fecha_ = "05-2018"
FECHA <- rep(fecha_, a1)
excel05 <- add_column(excel05, FECHA, .before = 1)

a1 <- as.numeric(nrow(excel06))
fecha_ = "06-2018"
FECHA <- rep(fecha_, a1)
excel06 <- add_column(excel06, FECHA, .before = 1)

a1 <- as.numeric(nrow(excel07))
fecha_ = "07-2018"
FECHA <- rep(fecha_, a1)
excel07 <- add_column(excel07, FECHA, .before = 1)

a1 <- as.numeric(nrow(excel08))
fecha_ = "08-2018"
FECHA <- rep(fecha_, a1)
excel08 <- add_column(excel08, FECHA, .before = 1)

a1 <- as.numeric(nrow(excel09))
fecha_ = "09-2018"
FECHA <- rep(fecha_, a1)
excel09 <- add_column(excel09, FECHA, .before = 1)

a1 <- as.numeric(nrow(excel10))
fecha_ = "10-2018"
FECHA <- rep(fecha_, a1)
excel10 <- add_column(excel10, FECHA, .before = 1)

a1 <- as.numeric(nrow(excel11))
fecha_ = "11-2018"
FECHA <- rep(fecha_, a1)
excel11 <- add_column(excel11, FECHA, .before = 1)

Data_final <- rbind(excel01[,c(1,2,3,4,5,6,7,8,9)],excel02[,c(1,2,3,4,5,6,7,8,9)]
                    ,excel03[,c(1,2,3,4,5,6,7,8,9)],excel04[,c(1,2,3,4,5,6,7,8,9)]
                    ,excel05[,c(1,2,3,4,5,6,7,8,9)],excel06[,c(1,2,3,4,5,6,7,8,9)]
                    ,excel07[,c(1,2,3,4,5,6,7,8,9)],excel08[,c(1,2,3,4,5,6,7,8,9)]
                    ,excel09[,c(1,2,3,4,5,6,7,8,9)],excel10[,c(1,2,3,4,5,6,7,8,9)],
                    excel11[,c(1,2,3,4,5,6,7,8,9)])
Data_final
```

    ## # A tibble: 2,180 × 9
    ##    FECHA   COD_VIAJE CLIENTE         UBICA…¹ CANTI…² PILOTO     Q CREDITO UNIDAD
    ##    <chr>       <dbl> <chr>             <dbl>   <dbl> <chr>  <dbl>   <dbl> <chr> 
    ##  1 01-2018  10000001 EL PINCHE OBEL…   76002    1200 Ferna… 300        30 Camio…
    ##  2 01-2018  10000002 TAQUERIA EL CH…   76002    1433 Hecto… 358.       90 Camio…
    ##  3 01-2018  10000003 TIENDA LA BEND…   76002    1857 Pedro… 464.       60 Camio…
    ##  4 01-2018  10000004 TAQUERIA EL CH…   76002     339 Angel…  84.8      30 Panel 
    ##  5 01-2018  10000005 CHICHARRONERIA…   76001    1644 Juan … 411        30 Camio…
    ##  6 01-2018  10000006 UBIQUO LABS ||…   76001    1827 Luis … 457.       30 Camio…
    ##  7 01-2018  10000007 CHICHARRONERIA…   76002    1947 Ismae… 487.       90 Camio…
    ##  8 01-2018  10000008 TAQUERIA EL CH…   76001    1716 Juan … 429        60 Camio…
    ##  9 01-2018  10000009 EL GALLO NEGRO…   76002    1601 Ismae… 400.       30 Camio…
    ## 10 01-2018  10000010 CHICHARRONERIA…   76002    1343 Ferna… 336.       90 Camio…
    ## # … with 2,170 more rows, and abbreviated variable names ¹​UBICACION, ²​CANTIDAD
    ## # ℹ Use `print(n = ...)` to see more rows

### Exportación del archivo

``` r
#exportaar el excel
write_excel_csv2(Data_final, "Data_final.xls", delim = ",")
```

### PARTE 2

### Moda de cada vector de la lista

``` r
# Función de moda
getmode <- function(v) {
   uniqv <- unique(v)
   uniqv[which.max(tabulate(match(v, uniqv)))]
}
# Función que crea un vector aleatoria de numeros
generate_numbers <-  function(x, tamanio){ return(
      b = sample(1:10, size = tamanio, replace = TRUE)
  )
}
## llenar la lista
lista <- lapply(1:3, generate_numbers, tamanio = 15) 
# LLamar a la función de moda, con la lista. 
result <- lapply(lista, getmode)
print(lista)
```

    ## [[1]]
    ##  [1]  6 10  6 10  9  8  8  2  1  7  5 10  4  6  8
    ## 
    ## [[2]]
    ##  [1]  7  6  3  4  9  1 10  4  1  5  1  7  8  5  1
    ## 
    ## [[3]]
    ##  [1]  1  2  4  6  6  3  7  1  8  6  7 10  7  9  8

``` r
print(result)
```

    ## [[1]]
    ## [1] 6
    ## 
    ## [[2]]
    ## [1] 1
    ## 
    ## [[3]]
    ## [1] 6

### PARTE 3

``` r
txt_1 <-read_delim('INE_PARQUE_VEHICULAR_080219.txt', delim = "|")
```

    ## New names:
    ## • `` -> `...11`

    ## Warning: One or more parsing issues, see `problems()` for details

    ## Rows: 2435294 Columns: 11
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: "|"
    ## chr (8): MES, NOMBRE_DEPARTAMENTO, NOMBRE_MUNICIPIO, MODELO_VEHICULO, LINEA_...
    ## dbl (2): ANIO_ALZA, CANTIDAD
    ## lgl (1): ...11
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
txt_1
```

    ## # A tibble: 2,435,294 × 11
    ##    ANIO_…¹ MES   NOMBR…² NOMBR…³ MODEL…⁴ LINEA…⁵ TIPO_…⁶ USO_V…⁷ MARCA…⁸ CANTI…⁹
    ##      <dbl> <chr> <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>     <dbl>
    ##  1    2007 05    HUEHUE… "HUEHU… 2007    SPORT1… MOTO    MOTOCI… ASIA H…       1
    ##  2    2007 05    EL PRO… "EL JI… 2007    BT-50 … PICK UP PARTIC… MAZDA         1
    ##  3    2007 05    SAN MA… "OCOS"  2007    JL125   MOTO    MOTOCI… KINLON        1
    ##  4    2007 05    ESCUIN… "SAN J… 2006    JL125T… MOTO    MOTOCI… JIALING       1
    ##  5    2007 05    JUTIAPA "MOYUT… 2007    JH100-2 MOTO    MOTOCI… JIALING       1
    ##  6    2007 05    GUATEM… "FRAIJ… 1997    TACOMA… PICK UP PARTIC… TOYOTA        1
    ##  7    2007 05    QUETZA… "QUETZ… 2007    ALTO L… AUTOMO… PARTIC… SUZUKI        1
    ##  8    2007 05    SUCHIT… "CHICA… 2007    AUTORI… MOTO    MOTOCI… BAJAJ         4
    ##  9    2007 05    ESCUIN… "ESCUI… 2007    SC 125… MOTO    MOTOCI… HONDA        11
    ## 10    2007 05    GUATEM… "MIXCO" 2007    GN125H  MOTO    MOTOCI… SUZUKI       15
    ## # … with 2,435,284 more rows, 1 more variable: ...11 <lgl>, and abbreviated
    ## #   variable names ¹​ANIO_ALZA, ²​NOMBRE_DEPARTAMENTO, ³​NOMBRE_MUNICIPIO,
    ## #   ⁴​MODELO_VEHICULO, ⁵​LINEA_VEHICULO, ⁶​TIPO_VEHICULO, ⁷​USO_VEHICULO,
    ## #   ⁸​MARCA_VEHICULO, ⁹​CANTIDAD
    ## # ℹ Use `print(n = ...)` to see more rows, and `colnames()` to see all variable names
