generate_df <-  function(x, tamanio){ return(
    data.frame(
      a = sample(letters, size = tamanio, replace = TRUE),
      b = sample(1:10, size = tamanio, replace = TRUE)
    )
  )
}
#parecido por un for, es un ciclo que aplica a todos los elementos del vector.
# 1:4, recorre y realiza la función a cada dato que pongo en el primer parámetro
# el primer parámetro de lapply es el primer parámetro que recibe la función. 
# luego pongo la función
# puedo agregar varios parámetros después
lista <- lapply(1:4, generate_df, tamanio = 4) 
lista
