dw-2022-parcial-1
================
Tepi
9/19/2022

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

# Examen parcial

Indicaciones generales:

-   Usted tiene el período de la clase para resolver el examen parcial.

-   La entrega del parcial, al igual que las tareas, es por medio de su
    cuenta de github, pegando el link en el portal de MiU.

-   Pueden hacer uso del material del curso e internet (stackoverflow,
    etc.). Sin embargo, si encontramos algún indicio de copia, se
    anulará el exámen para los estudiantes involucrados. Por lo tanto,
    aconsejamos no compartir las agregaciones que generen.

## Sección I: Preguntas teóricas.

-   Existen 10 preguntas directas en este Rmarkdown, de las cuales usted
    deberá responder 5. Las 5 a responder estarán determinadas por un
    muestreo aleatorio basado en su número de carné.

-   Ingrese su número de carné en `set.seed(20200118)` y corra el chunk
    de R para determinar cuáles preguntas debe responder.

``` r
#set.seed("escriba acá su carné") 
v<- 1:10
preguntas <-sort(sample(v, size = 5, replace = FALSE ))

paste0("Mis preguntas a resolver son: ",paste0(preguntas,collapse = ", "))
```

    ## [1] "Mis preguntas a resolver son: 2, 5, 8, 9, 10"

### Listado de preguntas teóricas: 1, 2, 7, 9, 10

1.  Para las siguientes sentencias de `base R`, liste su contraparte de
    `dplyr`:

    -   `str()`
    -   `df[,c("a","b")]`
    -   `names(df)[4] <- "new_name"` donde la posición 4 corresponde a
        la variable `old_name`
    -   `df[df$variable == "valor",]`

2.  Al momento de filtrar en SQL, ¿cuál keyword cumple las mismas
    funciones que el keyword `OR` para filtrar uno o más elementos una
    misma columna?

3.  ¿Por qué en R utilizamos funciones de la familia apply
    (lapply,vapply) en lugar de utilizar ciclos?

4.  ¿Cuál es la diferencia entre utilizar `==` y `=` en R?

5.  ¿Cuál es la forma correcta de cargar un archivo de texto donde el
    delimitador es `:`?

6.  ¿Qué es un vector y en qué se diferencia en una lista en R?

7.  ¿Qué pasa si quiero agregar una nueva categoría a un factor que no
    se encuentra en los niveles existentes?

8.  Si en un dataframe, a una variable de tipo `factor` le agrego un
    nuevo elemento que *no se encuentra en los niveles existentes*,
    ¿cuál sería el resultado esperado y por qué?

    -   El nuevo elemento
    -   `NA`

9.  En SQL, ¿para qué utilizamos el keyword `HAVING`?

10. Si quiero obtener como resultado las filas de la tabla A que no se
    encuentran en la tabla B, ¿cómo debería de completar la siguiente
    sentencia de SQL?

    -   SELECT \* FROM A \_\_\_\_\_\_\_ B ON A.KEY = B.KEY WHERE
        \_\_\_\_\_\_\_\_\_\_ = \_\_\_\_\_\_\_\_\_\_

Extra: ¿Cuántos posibles exámenes de 5 preguntas se pueden realizar
utilizando como banco las diez acá presentadas? (responder con código de
R.)

## Sección II Preguntas prácticas.

-   Conteste las siguientes preguntas utilizando sus conocimientos de R.
    Adjunte el código que utilizó para llegar a sus conclusiones en un
    chunk del markdown.

A. De los clientes que están en más de un país,¿cuál cree que es el más
rentable y por qué?

B. Estrategia de negocio ha decidido que ya no operará en aquellos
territorios cuyas pérdidas sean “considerables”. Bajo su criterio,
¿cuáles son estos territorios y por qué ya no debemos operar ahí?

### I. Preguntas teóricas: 1, 2, 7, 9, 10

# 1. Para las siguientes sentencias de `base R`, liste su contraparte de `dplyr`:

Respuesta:

``` r
# `str()` 
#      R1: `dplyr`:``
# `df[,c("a","b")]`
#      R2: dplyr`:`select(df, a, b)`
# `names(df)[4] <- "new_name"` donde la posición 4 corresponde a la variable `old_name`
#      R3: `dplyr`:`rename(df, "new_name" = "old_name")`    
# `df[df$variable == "valor",]`
#      R4: `dplyr`:`filter(variable == "valor")`
```

# 2. Al momento de filtrar en SQL, ¿cuál keyword cumple las mismas funciones que el keyword `OR` para filtrar uno o más elementos una misma columna?

Respuesta: se puede usar la keyword: `|`.

      Por ejemplo:
      library(dplyr)
        parcial_anonimo %>% 
          filter(Pais == '4046ee34' | Pais == '4046ee35')

# 7. ¿Qué pasa si quiero agregar una nueva categoría a un factor que no se encuentra en los niveles existentes?

Respuesta: Para agregar un nuevo nivel de factor, no hay problema. Solo
se debe de sobre escribir en los levels del factor, un vector de los
levels ya existentes y luego agregar como segundo valor del vector el
nuevo factor.

``` r
#ejemplo link:
#https://stackoverflow.com/questions/23316815/add-extra-level-to-factors-in-dataframe 
f1 <- factor(c("a", "a", NA, NA, "b", NA, "a", "c", "a", "c", "b"))
str(f1)
```

    ##  Factor w/ 3 levels "a","b","c": 1 1 NA NA 2 NA 1 3 1 3 ...

``` r
levels(f1) <- c(levels(f1),"No Answer")
f1[is.na(f1)] <- "No Answer"
str(f1)
```

    ##  Factor w/ 4 levels "a","b","c","No Answer": 1 1 4 4 2 4 1 3 1 3 ...

# 9. En SQL, ¿para qué utilizamos el keyword `HAVING`?

Respuesta: En SQL la keyword HAVING es como un where o una forma de
realizar comparaciones luego de haber usado la keyword: group_by. Es
para cuando el where no soporta funciones de agrupación.

# 10. Si quiero obtener como resultado las filas de la tabla A que no se encuentran en la tabla B, ¿cómo debería de completar la siguiente sentencia de SQL?

        SELECT * FROM A _______ B ON A.KEY = B.KEY WHERE __________ = __________

Respuesta: SELECT \* FROM A ***LEFT JOIN TableB*** B ON A.KEY = B.KEY
WHERE **B.key** **IS NULL**

## A

``` r
###resuelva acá
parcial_anonimo <- readRDS("parcial_anonimo.rds")

#A. De los clientes que están en más de un país,¿cuál cree que es el más rentable y por qué?

# Clientes restables con más ventas

#total de clientes:
parcial_anonimo %>% 
  select(Cliente) %>%
  summarise(total_cliente = n_distinct(Cliente)) 
```

    ##   total_cliente
    ## 1          2147

``` r
#Clientes agrupados con el pais:
cliente_paises <- parcial_anonimo %>% 
  select(Cliente, Pais) %>%
  group_by(Cliente, Pais) %>%
  summarise(entrega = n()) %>%
  arrange(desc(Cliente))
```

    ## `summarise()` has grouped output by 'Cliente'. You can override using the
    ## `.groups` argument.

``` r
# Clientes ccon más de un pais
clientes_mas <- cliente_paises %>%
                count(Cliente) %>%
                filter(n > 1)
# Clientes más rentables
masrentables <- parcial_anonimo %>%
                  select(Cliente, Venta) %>%
                  group_by(Cliente) %>%
                  filter(Cliente %in% (clientes_mas$Cliente)) %>%
                  summarise(ventas_totales = sum(Venta)) %>%
                  arrange(desc(ventas_totales))
```

## B

``` r
###resuelva acá
#B. Estrategia de negocio ha decidido que ya no operará en aquellos territorios cuyas pérdidas sean "considerables". Bajo su criterio, ¿cuáles son estos territorios y por qué ya no debemos operar ahí?

# Se considerará un territorio con pérdidad considerables, aquellos que tengan el promedio de sus ventas por debajo de la media general. 
parcial_anonimo <- readRDS("parcial_anonimo.rds")
media_ventas <- parcial_anonimo %>%
                  select(Venta) %>%
                  summarise(ventas_promedio = mean(Venta))

Territorias_fuera <- parcial_anonimo %>%
                      select(Territorio, Venta) %>%
                      group_by(Territorio) %>%
                      summarise(promedio_territorio = mean(Venta)) %>%
                      filter(promedio_territorio < media_ventas[1,1])
library(DT)

DT::datatable(Territorias_fuera)
```

<div id="htmlwidget-25f32f3c1543e1293ccd" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-25f32f3c1543e1293ccd">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77"],["0320288f","0bbe6418","0bfe69a0","0dd30fcd","0ef0ce97","0f915ffc","11676773","13b223c9","14c263f1","1a9b2b4c","1d407777","1e107bf6","1fac8d59","2e812869","3153c73e","3350838e","368301e2","3cae948b","3e0d75d0","4163fa3f","456278b8","45c0376d","4814799f","4ca9988b","4f860572","54969a29","55f0e537","5a464f3f","5d43dd39","64e2147f","67a61c29","67e9cc18","6837187c","6899442b","68de9759","69c1b705","6c8335a4","6eff1266","77192d63","79428560","7b674f31","80d1e625","81062400","8682908b","90e89bb4","91e7e31b","9b45ae60","9de43341","9fdcc550","a7ee3287","a9e783db","abfa1d4e","aed8e579","b20448cf","b50e91fb","b53a9360","b97335a1","bf1e94e9","c072f75a","c09056e6","c300284d","c31adb2f","cc471eed","cf970512","d02bf225","d43e8f6a","d741afb6","dfd48934","e034e3c8","e6fd9da9","ee3eb62b","f7dfc635","f871212f","f8e2b63c","f97a3f33","fce0345f","fed6647d"],[7.97547169811321,15.7657092198582,5.82333333333333,21.4723517883391,21.1453959683225,7.81796163069544,17.3756675749319,8.32333333333333,14.002274211099,21.8953741496599,25.2251226729133,12.4922702702703,13.4280681818182,16.450915125652,22.4206088992974,15.1551185770751,6.0735,25.7177594680543,17.0173684210526,8.91738461538462,6.65554054054054,9.12251928020566,14.0574739281576,22.2161311341886,13.0282425742574,26.4738406827881,25.565327510917,16.0367224080268,11.4673097345133,6.98659420289855,16.7469090909091,17.4735796002757,17.1261674008811,22.9916301703163,14.9978947368421,20.9482518538863,10.0679271708683,23.1766666666667,18.5415823022122,14.6666666666667,18.8058556832695,16.0269830713422,8.98688405797101,16.529605734767,10.0235925925926,22.9491617021277,13.5550746268657,8.81809116809117,21.2384,13.9494277803415,18.5020857596612,16.5093089123867,10.2347945205479,11.0798460222412,21.4469551901999,16.4766326530612,15.5124230568597,4.00401603206413,16.5326063829787,12.1218987341772,15.5308139534884,18.1675735294118,16.8765656565657,23.2671167883212,7.87550898203593,11.6554897959184,7.69683544303797,15.2106327462492,4.75307692307692,1.51333333333333,11.178073519401,22.7789825328596,10.5887790697674,21.3476271186441,19.7353174603175,9.6761738002594,20.8835474860335]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>Territorio<\/th>\n      <th>promedio_territorio<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":2},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
