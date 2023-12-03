# TRABAJO DE NIMER LOPEZ Y ANDREY RODRIGUEZ, TRABAJO DE MINERIA DE DATOS.

# Vamos a cargar las librerias necesarias
getwd()
setwd()

library(zoo)
library(dplyr)
library(ggplot2)
library(readxl)


#llama al archivo excel
data <- read_excel("Files/rentadebicis.xlsx")


#Obtiene informacion de las columnas y datos
head(data)
class(data)
names(data)
glimpse(data)
str(data)
dim(data)
colnames(data)

View(data)

# Con esto se obtine un resumen estadístico de variables numéricas
summary(data)


# Verifica la cantidad de valores nulos por columna
# Con ese comando se verifico que no se encontraron valores nulos en ninguna columna
colSums(is.na(data))


# Esta linea elimina la hora por que no me proporciona ningun dato importante al analisis de datos, podemos volver a verificar que se elimino la colunma de hora.
data <- data[, !colnames(data) %in% c("hora")]


# Valores normales antes de ser procesados
datosx <- data

# Vemos un grafico de los valores atipicos
boxplot(datosx$rentas_totales) 

# Calcula el rango intercuartílico
Q1 <- quantile(datosx$rentas_totales, 0.25)
Q3 <- quantile(datosx$rentas_totales, 0.75)
IQR_val <- Q3 - Q1

# Identifica valores atípicos
lower <- Q1 - 1.5 * IQR_val
upper <- Q3 + 1.5 * IQR_val
outliers <- data[datosx$rentas_totales < lower | datosx$rentas_totales > upper, ]

# Imprime los valores atípicos
print(outliers)
View(outliers)
outliers_values <- as.numeric(outliers$rentas_totales)
#valores atipicos procesados
boxplot(outliers$rentas_totales) 
# Esto va a crear un gráfico de caja de rentas totales por mes
boxplot(rentas_totales ~ mes, data = datosx, 
        xlab = "Mes", ylab = "Rentas Totales",
        main = "Boxplot de Rentas Totales por Mes")



# Esto va a crear un gráfico de caja de rentas totales
boxplot(data$rentas_totales) 

# Esto va a crear un gráfico de caja de rentas totales por mes
boxplot(rentas_totales ~ mes, data = datos, 
        xlab = "Mes", ylab = "Rentas Totales",
        main = "Boxplot de Rentas Totales por Mes")


# Esto calcula la media de la concentración
media_concentracion <- mean(data$rentas_totales)

# Esto calcula la mediana de la concentración
mediana_concentracion <- median(data$rentas_totales)

# Esto calcula la desviación estándar
desviacion_estandar <- sd(data$rentas_totales)

# Ahora imprimo los resultados
cat("Media de Concentración:", media_concentracion, "\n")
cat("Mediana de Concentración:", mediana_concentracion, "\n")
# Ahora la desviación estándar
cat("Desviación estándar:", desviacion_estandar, "\n")




#Imputacion

#Como son muchos valores se decidio hacer un cambio a los valores y aplicar la Imputación por la media o mediana

# Imputar valores faltantes por la mediana
datosx$rentas_totales <- na.aggregate(datosx$rentas_totales, FUN = median)

# Verificar que los valores faltantes se hayan imputado
View(datosx)
# Valores con la imputacion
boxplot(datosx$rentas_totales)


# En este diagrama se observan las rentas por mes
datosx$Nombre_Mes <- factor(datosx$mes, labels = c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"))
ggplot(datosx, aes(x = Nombre_Mes, y = rentas_totales, fill = Nombre_Mes)) +
  geom_bar(stat = "identity") +
  labs(title = "Rentas por mes",
       x = "Meses",
       y = "Ventas") +
  theme_minimal() +
  coord_flip()


# En este diagrama se observan las rentas por estacion
ggplot(datosx, aes(x = "", y = rentas_totales, fill = factor(estacion))) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  labs(title = "Rentas totales por estación",
       fill = "Estación",
       x = NULL,
       y = NULL) +
  theme_minimal() +
  theme(axis.text.x = element_blank())


# En este diagrama se observan las rentas por año
ggplot(datosx, aes(x = "", y = rentas_totales, fill = factor(año))) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  labs(title = "Rentas Totales por Año",
       fill = "Año",
       x = NULL,
       y = NULL) +
  theme_minimal() +
  theme(axis.text.x = element_blank(),
        legend.title = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 10),
        legend.text = element_text(size = 12),
        legend.position = "top",
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14)) +
  scale_fill_brewer(palette = "Set3")


# Análisis Univariable
# Resumen estadístico de la variable 'rentas_totales'
summary(data$rentas_totales)

# Histograma de 'rentas_totales'
hist(data$rentas_totales, main = "Distribución de Rentas Totales", xlab = "Rentas Totales")

# Boxplot de 'rentas_totales'
boxplot(data$rentas_totales, main = "Boxplot de Rentas Totales", ylab = "Rentas Totales")


# Análisis Bivariable
# Diagrama de dispersión para ver la relación entre 'rentas_totales' y 'mes'
plot(data$mes, data$rentas_totales, xlab = "Mes", ylab = "Rentas Totales", main = "Relación entre Mes y Rentas Totales")

# Correlación entre 'rentas_totales' y 'mes'
correlation <- cor(data$mes, data$rentas_totales)
cat("Correlación entre Mes y Rentas Totales:", correlation, "\n")

# Con esto estamos haciendo un analisis de correlacion de todos los datos
df<-datosx 
df$Species<-NULL
cor(df)





