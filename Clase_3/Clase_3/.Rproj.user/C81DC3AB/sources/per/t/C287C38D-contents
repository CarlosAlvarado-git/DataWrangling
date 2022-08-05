generate_df <-  function(tamanio, x){ return(
      b = sample(1:10, size = tamanio, replace = TRUE)
  )
}
#parecido por un for, es un ciclo que aplica a todos los elementos del vector.
# 1:4, recorre y realiza la función a cada dato que pongo en el primer parámetro
# el primer parámetro de lapply es el primer parámetro que recibe la función. 
# luego pongo la función
# puedo agregar varios parámetros después
a <- c(1,2,3)
lista <- lapply(4, generate_df,1:3) 
lista

###

# Create the function.
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# Create the vector with numbers.
v <- c(2,1,2,3,1,2,3,4,1,5,5,3,2,3)

# Calculate the mode using the user function.
result <- getmode(v)
print(result)






###

library(tibble)
dataset <- data.frame(a = 1:5, b = 2:6, c=3:7)

generate_df <-  function(data_, fecha){ 
  a <- as.numeric(nrow(data_))
  a
  fechas <- rep(fecha, a)
  data_ <- add_column(data_, fechas, .before = 1)
}
#parecido por un for, es un ciclo que aplica a todos los elementos del vector.
# 1:4, recorre y realiza la función a cada dato que pongo en el primer parámetro
# el primer parámetro de lapply es el primer parámetro que recibe la función. 
# luego pongo la función
# puedo agregar varios parámetros después

lapply(dataset, generate_df, fecha = "01-2018") 

a1 <- as.numeric(nrow(dataset))
fecha_ = "01-2018"
fff <- rep(fecha_, a1)
dataset <- add_column(dataset, fff, .before = 1)
