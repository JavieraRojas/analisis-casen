# Cargar base de datos desde SPSS


# Guardar en formato RDS
CASENCOMUNAS <- readRDS("Data/InputData/casen_2017_RM.rds")

CASENCOMUNAS <- filter(CASENCOMUNAS, comuna == 13121| comuna == 13131| comuna == 13103| comuna == 13108|
                         comuna ==13127| comuna == 13116| comuna == 13111| comuna == 13112|
                         comuna ==13104 | comuna == 13128|comuna ==13129|comuna ==13117)  

write.csv2(CASENCOMUNAS, file = "Data/IntermediateData/casen_2017_comunas.csv")


# Limpiar entorno de trabajo
rm(list=ls())
