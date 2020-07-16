# Evaluación de instalación/carga de paquetes
# Crea función: sólo si no está instalado, ejecuta instalación, siempre carga el paquete
# Ejecutar sin modificar
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

# Editar para paquetes requeridos: deben considerarse todos los paquetes necesarios en el proyecto
# Es decir, en cada script
paquetes <- c("haven", "dplyr", "car", "summarytools", "ggplot2")
ipak(paquetes)

# Ejecuta código 1: lectura base datos
# Expulsa archivo de datos para editar
source("Scripts/Processing/load-data.R")

# Ejecuta código 2: preparación de datos
# Carga datos para editar, expulsa archivo de datos editados
source("Scripts/Processing/prepare-data.R")

# Ejecuta código 3: construcción de resultados
# Carga datos editados, expulsa lista de resultados como archivo
source("Scripts/Analysis/results.R")

# Ejecuta código 4: construcción de reporte reproducible
# En base a lista de resultados, crea archivo de reporte en PDF
rmarkdown::render("ReproducibleReport/reporte_reproducible.Rmd")

# Limpiar entorno de trabajo
rm(list=ls())
