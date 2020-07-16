# Leer desde archivo CSV intermedio
CASENRM <- read.csv2("Data/IntermediateData/casen_2017_comunas.csv")


#---1. Seleccionar variables de interés ---

CASENRM <- select(CASENRM, Comuna=comuna, expc, expr, varstrat, niveleducacional = e6a,
                  empleo = o15, Salario_Líquido = y1, hogar = pco1,
                  rama = rama1, pobrezaingresos = pobreza, 
                  pobrezamultidimensional = pobreza_multi_5d, hacinamiento, prevision = s12)

#---2. Recodificar variables (educación, empleo, rama, pobreza por ingresos, pobreza multimensional, hacinamiento)

#Convertir a factor para poner etiquetas

#Comuna
CASENRM$Comuna <- factor(CASENRM$Comuna, labels = c(
  "Cerro Navia", 
  "Conchalí",
  "Independencia",
  "La Granja",
  "La Pintana",
  "Lo Espejo",
  "Lo Prado",
  "Pedro Aguirre Cerda",
  "Recoleta",
  "Renca",
  "San Joaquín",
  "San Ramón"))

#Educación (nominal)
table(CASENRM$niveleducacional)
CASENRM <- mutate(CASENRM, educa = car::recode(CASENRM$niveleducacional, "1:8=1;9:11=2;12:17=3;99=NA"))
CASENRM <- mutate(CASENRM, "Educación" = factor(CASENRM$educa, labels =(c("Básica","Media","Superior"))))
table(CASENRM$Educación)

#Empleo

table (CASENRM$empleo)
CASENRM <- mutate(CASENRM, empleo_rec = car::recode(CASENRM$empleo, "1=1;2=2;3:5=3;6:7=4;8=5;9=6"))
CASENRM <- mutate(CASENRM, Empleo = factor(CASENRM$empleo_rec, labels =(c("Empleador", "TCP", "Obrero",
                                                                             "Serv. Dom.", "FFAA", "FNR"))))
table(CASENRM$Empleo)

#Rama
table(CASENRM$rama)
CASENRM <- mutate(CASENRM, rama_rec = car::recode(CASENRM$rama, "4=1;6=2;7=3;9=4;1:3=5;5=5;8=5;10:17=5;999=NA;else=NA"))
table(CASENRM$rama_rec)
CASENRM <- mutate(CASENRM, Rama = factor(CASENRM$rama_rec,
                                                levels = c(1,2,3,4,5),
                                                labels =(c("Industria",
                                                           "Construcción",
                                                           "Comercio",
                                                           "Transporte",
                                                           "Otra"))))

table(CASENRM$Rama)

#Pobreza por ingresos

table (CASENRM$pobrezaingresos)
CASENRM <- mutate(CASENRM, pobrezaing_rec = car::recode(CASENRM$pobrezaingresos, "1:2=1;3=2"))
CASENRM <- mutate(CASENRM, Pobreza_Ingresos = factor(CASENRM$pobrezaing_rec, labels =(c("Sí","No"))))
table(CASENRM$Pobreza_Ingresos)

#Pobreza multidimensional
table (CASENRM$pobrezamultidimensional)
class (CASENRM$pobrezamultidimensional)
CASENRM <- mutate(CASENRM, Pobreza_Multidimensional = factor(CASENRM$pobrezamultidimensional, levels = c(1,0),
                                                        labels =(c("Sí","No"))))
table(CASENRM$Pobreza_Multidimensional)

#Hacinamiento
table (CASENRM$hacinamiento)
class (CASENRM$hacinamiento)
CASENRM <- mutate(CASENRM, hacin_rec = car::recode(CASENRM$hacinamiento, "1=1;2:3=2;4=3;9=NA"))
CASENRM <- mutate(CASENRM, Hacinamiento = factor(CASENRM$hacin_rec, labels =(c("Sin","Medio", "Crítico"))))
table(CASENRM$Hacinamiento)

#Prevision
table(CASENRM$prevision)
CASENRM <- mutate(CASENRM, Salud = car::recode(CASENRM$prevision, "1:5=1;6=2;7=3;8=4;9=5;99=NA"))
table(CASENRM$Salud)
CASENRM$Salud <- factor(CASENRM$Salud, labels =(c("FONASA","FFAA", "ISAPRE","Particular","Otro")))

# ---- 3. GUARDAR BASE EDITADA EN FORMATO R ----

# Guardar base en formato RDS, con bases listas para análisis
saveRDS(CASENRM, file = "Data/IntermediateData/casen-editada.rds")

# Limpiar entorno de trabajo
rm(list=ls())

