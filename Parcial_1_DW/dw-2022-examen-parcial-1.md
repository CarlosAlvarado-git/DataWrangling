dw-2022-parcial-1
================
Tepi
9/19/2022

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

    ## [1] "Mis preguntas a resolver son: 1, 6, 8, 9, 10"

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
#      R2: 
# `names(df)[4] <- "new_name"` donde la posición 4 corresponde a la variable `old_name`
#      R3: `dplyr`:`rename(df, "new_name" = "old_name")`    
# `df[df$variable == "valor",]`
#      R4: 
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

Respuesta: - SELECT \* FROM A ***LEFT JOIN TableB*** B ON A.KEY = B.KEY
WHERE **B.key** **IS NULL**

## A

``` r
###resuelva acá
```

## B

``` r
###resuelva acá
```
