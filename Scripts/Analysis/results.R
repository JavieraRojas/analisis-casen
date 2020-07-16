# Cargar base de datos

CASENRM <- readRDS("Data/IntermediateData/casen-editada.rds")

#---1. Construir resultados ---

#Tablas de doble entrada con "summarytools", ponderada a nivel comunal

#Tabla 1: Nivel educacional según comuna RM (OK, verificada con excel)
tabla1 <-  ctable(CASENRM$Comuna, CASENRM$Educación, prop = "r",
                     weights = CASENRM$expc, style = 'rmarkdown', useNA = "no", 
                     totals = F)

#Tabla 2: Hacinamiento según comuna RM
CASENRM_hogar <- filter(CASENRM, hogar == 1)

tabla2 <- ctable(CASENRM_hogar$Comuna, CASENRM_hogar$Hacinamiento, prop = "r",
                       weights = CASENRM_hogar$expc, headings = F, 
                 style = 'rmarkdown', useNA = "no", totals = F)

#Tabla 3: Pobreza por ingresos según comuna RM (OK, revisado según excel)
tabla3 <- ctable(CASENRM$Comuna, CASENRM$Pobreza_Ingresos, prop = "r",
       weights = CASENRM$expc, headings = F, style = 'rmarkdown', 
       useNA = "no", totals = F)

#Tabla 4: Pobreza multidimensional según comuna RM (OK, revisado seǵun excel)
tabla4 <- ctable(CASENRM$Comuna, CASENRM$Pobreza_Multidimensional, prop = "r",
       weights = CASENRM$expc, headings = F, style = 'rmarkdown', 
       useNA = "no", totals = F)

#Tabla 5: Categoria empleo según comuna RM
tabla5 <- ctable(CASENRM$Comuna, CASENRM$Empleo, prop = "r",
       weights = CASENRM$expc, headings = F,
       useNA = "no", totals = F, style = 'rmarkdown')

#Tabla 6: Rama económica según comuna RM
tabla6 <- ctable(CASENRM$Comuna, CASENRM$Rama, prop = "r",
       weights = CASENRM$expc, headings = F, style = 'rmarkdown', 
       useNA = "no", totals = F)

#Tabla 7: Q1, mediana, media, Q3 y máximo Salario liquido por comuna de la RM
tabla7 <- with(CASENRM, stby(data= Salario_Líquido, INDICES = Comuna, FUN = descr, 
                             stats = c("med", "mean", "max"), weights = CASENRM$expc, transpose = T,
                             style = 'rmarkdown', headings = F))

# Tabla 8: sistema de salud según comuna
tabla8 <- ctable(CASENRM$Comuna, CASENRM$Salud, prop = "r",
                       weights = CASENRM$expc, headings = F, style = 'rmarkdown', 
                       useNA = "no", totals = F)

# --- 2. COMPILAR RESULTADOS EN UN SÓLO OBJETO (LISTA) Y GUARDAR COMO ARCHIVO ----

resultados <- list(tabla1, tabla2, tabla3, tabla4, tabla5, tabla6, tabla7, tabla8)

saveRDS(resultados, file = "Data/AnalysisData/resultados-reporte.rds")

# Limpiar entorno de trabajo
rm(list=ls())
