# Base de datos original (formato .sav) disponible para descarga en:
# http://observatorio.ministeriodesarrollosocial.gob.cl/casen-multidimensional/casen/casen_2017.php
# De forma off-line se convirtió a formato RDS para facilitar almacenamiento en Github.

# Cargar base completa a entorno de trabajo
CASEN <- readRDS("Data/InputData/casen_2017.rds")

# Filtrar según comunas de interés
CASENCOMUNAS <- filter(CASEN, comuna == 13121| comuna == 13131| comuna == 13103| comuna == 13108|
                         comuna ==13127| comuna == 13116| comuna == 13111| comuna == 13112|
                         comuna ==13104 | comuna == 13128|comuna ==13129|comuna ==13117)  

# Guardar en formato CSV para eliminar información proveniente de SPSS
write.csv2(CASENCOMUNAS, file = "Data/IntermediateData/casen_2017_comunas.csv")


# Limpiar entorno de trabajo
rm(list=ls())
