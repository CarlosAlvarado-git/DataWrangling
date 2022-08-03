getwd()

string <- "una cadena de texto"
class(string)
length(string)
nchar(string)
#ufunc -> elementos atomicos, vectores. 
numero <- 1
integ <- 2L
logical <- FALSE
#filtrar y crear condiciones en matrices, tablas. 
vector <- c(1,2,3)
23:45
sample(x=1:5, size=8, replace = TRUE) # sub set del vector, replace = true
                                      # me permite hacer un set, con cantidad
                                      # más grande que la del vector original
#FACTORES
factor_1 <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon", "Wed", "Thu")
factor(factor_1)
#existen factores ordenados

factor_2 <- ordered(factor_1, levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))
factor_2

#Categorizar de forma numerica
as.numeric(factor_2)

vector_2 <- c(1,2,3,4,5)
vector_3 <- c(FALSE, TRUE, FALSE)
vector_4 <- c("a", "b", "c")
vector_5 <- c("a", 1, "v") # cambia el numero a texto. 

lista_1 <- list(vector_2, vector_3,vector_4,vector_5)

lista_1[[1]]

names(lista_1)
#remplazar
names(lista_1) <- c("first", "second", "third", "fourth")
lista_1$first


#DATAFRAMES

df <- data.frame(
  col1 = c("Vector", "de", "strings"),
  col1 = 1:3,
  col3 = letters[1:3],
  stringsAsFactors = FALSE
)
#el str me da info del data frame, las variables, son columnas. obs filas
str(df)
nrow(df)
ncol(df)
#rbind no cambia la variables que recibe el nuevo elemento. 
rbind(df, c("ggs", 12, "z"))