# ELECTIVO: CIENCIA ABIERTA Y SOFTWARE LIBRE
# MAGÍSTER EN CCSS UNIVERSIDAD DE CHILE - 2020 
# Javiera Rojas Cifuentes

# ---1. Cargar datos y paquetes de funciones para análisis ---

install.packages(c("summarytools","haven","dplyr"))

library(haven)
library(dplyr)
library(summarytools)


CASENRM <- readRDS("datos/casen_2017_RM.rds")


#---2. Seleccionar variables de interés ---

CASENRM <- select(CASENRM, comuna, expc, varstrat, niveleducacional = e6a,
                  empleo = o15, salarioliquido = y1, 
                  rama = rama1, pobrezaingresos = pobreza, 
                  pobrezamultidimensional = pobreza_multi_5d, Hacinamiento = hacinamiento)

#---3. Recodificar variables (educación, empleo, rama, pobreza por ingresos, pobreza multimensional, hacinamiento)

#Convertir a factor para poner etiquetas

#Educación (nominal)

table (CASENRM$niveleducacional)
class(CASENRM$niveleducacional)
CASENRM$niveleducacional <- as.numeric(CASENRM$niveleducacional) #convertir a vector numérico para poder transformar

CASENRM <- mutate(CASENRM, educ_factor = factor(CASENRM$niveleducacional, labels =(c("Nunca asistio", "Sala cuna", "Jardín infantil", "Prekinder/Kinder", "Educación Especial","Primaria", "Ed básica", "Humanidades", "Educación media científica-humanista", "Técnica, comercial, industrial o normalista", "Educación media técnica profesional", "Técnico nivel superior incompleto", "Técnico nivel superior completo","Profesional incompleto", "Profesional completo", "Postgrado incompleto", "Postgrado completo","No sabe/no responde"))))
class(CASENRM$educ_factor) #queda como objeto character
CASENRM$educ_factor #visualizar datos concretos guardados
table(CASENRM$educ_factor)

#Empleo

table (CASENRM$empleo)
class (CASENRM$empleo)
CASENRM$empleo <- as.numeric(CASENRM$empleo) #convertir a vector numérico para poder transformar

CASENRM <- mutate(CASENRM, empleo_factor = factor(CASENRM$empleo, labels =(c("Empleador", "Trabajador por cuenta propia", "Obrero del sector público", "Obrero de empresas públicas", "Obrero del sector privado","Servicio doméstico puertas adentro", "Servicio doméstico puertas afuera", "FF.AA. y del Orden", "Familiar no remunerado"))))
class(CASENRM$empleo_factor) #queda como objeto character
CASENRM$empleo_factor #visualizar datos concretos guardados
table(CASENRM$empleo_factor)

#Rama

table (CASENRM$rama)
class (CASENRM$rama)
CASENRM$rama <- as.numeric(CASENRM$rama) #convertir a vector numérico para poder transformar

CASENRM <- mutate(CASENRM, rama_factor = factor(CASENRM$rama, labels =(c("Agricultura, ganadería, caza y silvicultura", "Pesca", "Explotación de minas y canteras", "Industrias manufactureras", "Suministro de electricidad, gas y agua", "Construcción", "Comercio al por mayor y al por menor", "Hoteles y restaurantes", "Transporte, almacenamiento y comunicaciones", "Intermediación financiera", "Actividades inmobiliarias, empresariales y de alquiler", "Administración pública y defensa", "Enseñanza", "Servicios sociales y de salud", "Otras actividades de servicios comunitarios, sociales", "Hogares privados con servicio doméstico", "Organizaciones y órganos extraterritoriales", "Sin dato"))))
class(CASENRM$rama_factor) #queda como objeto character
CASENRM$rama_factor #visualizar datos concretos guardados
table(CASENRM$rama_factor)
summary(CASENRM$rama_factor)

#Pobreza por ingresos

table (CASENRM$pobrezaingresos)
class (CASENRM$pobrezaingresos)
CASENRM$pobrezaingresos <- as.numeric(CASENRM$pobrezaingresos) #convertir a vector numérico para poder transformar

CASENRM <- mutate(CASENRM, pobrezaingresos_factor = factor(CASENRM$pobrezaingresos, labels =(c("Pobres extremos","Pobres no extremos", "No pobres"))))
class(CASENRM$pobrezaingresos_factor) #queda como objeto character
CASENRM$pobrezaingresos_factor #visualizar datos concretos guardados
table(CASENRM$pobrezaingresos_factor)

#Pobreza multidimensional

table (CASENRM$pobrezamultidimensional)
class (CASENRM$pobrezamultidimensional)
CASENRM$pobrezamultidimensional <- as.numeric(CASENRM$pobrezamultidimensional) #convertir a vector numérico para poder transformar

CASENRM <- mutate(CASENRM, pobrezamulti_factor = factor(CASENRM$pobrezamultidimensional, labels =(c("No pobre","Pobre"))))
class(CASENRM$pobrezamulti_factor) #queda como objeto character
CASENRM$pobrezamulti_factor #visualizar datos concretos guardados
table(CASENRM$pobrezamulti_factor)

#Hacinamiento

table (CASENRM$Hacinamiento)
class (CASENRM$Hacinamiento)
CASENRM$Hacinamiento <- as.numeric(CASENRM$Hacinamiento) #convertir a vector numérico para poder transformar

CASENRM <- mutate(CASENRM, hacinamiento_factor = factor(CASENRM$Hacinamiento, labels =(c("Sin hacinamiento","Hacinamiento medio bajo", "Hacinamiento medio alto", "Hacinamiento crítico", "NS/NR"))))
class(CASENRM$hacinamiento_factor) #queda como objeto character
CASENRM$hacinamiento_factor #visualizar datos concretos guardados
table(CASENRM$hacinamiento_factor)

#Convertir variable "Salario líquido" a vector numérico para poder transformar 

table (CASENRM$salarioliquido)
class (CASENRM$salarioliquido)
CASENRM$salarioliquido <- as.numeric(CASENRM$salarioliquido)
summary(CASENRM$salarioliquido)

#---4. Construir resultados ---

#Tablas de doble entrada con "summarytools", ponderada a nivel comunal

#Tabla 1: Nivel educacional según comuna RM
ctable(CASENRM$comuna, CASENRM$educ_factor, prop = "r",
       weights = CASENRM$expc)

#Tabla 2: Hacinamiento según comuna RM
ctable(CASENRM$comuna, CASENRM$hacinamiento_factor, prop = "r",
       weights = CASENRM$expc)

#Tabla 3: Pobreza multidimensional según comuna RM
ctable(CASENRM$comuna, CASENRM$pobrezamulti_factor, prop = "r",
       weights = CASENRM$expc)

#Tabla 4: Pobreza por ingresos según comuna RM
ctable(CASENRM$comuna, CASENRM$pobrezaingresos_factor, prop = "r",
       weights = CASENRM$expc)

#Tabla 5: Categoría empleo según comuna RM
ctable(CASENRM$comuna, CASENRM$empleo_factor, prop = "r",
       weights = CASENRM$expc)

#Tabla 6: Rama económica según comuna RM
ctable(CASENRM$rama_factor, CASENRM$comuna, prop = "c",
       weights = CASENRM$expc)

#Tabla 7: Media, mediana, mínimo y máximo Salario líquido RM
descr(CASENRM$salarioliquido, transpose = T, stats = "common", weights = CASENRM$expc)

#Tabla 8: Q1, mediana, media, Q3 y máximo Salario líquido por comuna de la RM [Pendiente de resolver la función "weights"]
with(CASENRM, stby(data= salarioliquido, INDICES = comuna,
                        FUN = descr, 
                        stats = c("med", "mean", "max"), weights = CASENRM$expc,
                        transpose = T))

#Tabla 9: Rama económica según mediana del salario líquido RM [Pendiente de resolver la función "weights"]
with(CASENRM, stby(data= salarioliquido, INDICES = rama_factor,
                   FUN = descr, 
                   stats = "common", weights = CASENRM$expc,
                   transpose = T))


