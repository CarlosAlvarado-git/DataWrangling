library(readr)
library(dplyr)
data <- read_csv("c1.csv")
data <- data[,c(-23,-24,-25,-26,-27,-28)]
#data[,3] <- as.numeric(data[,3])
