library(tidyverse)
library(rio)
library(googledrive)
library(janitor)

drive_auth('clopezpinto.gcba@gmail.com', cache = gargle::gargle_oauth_cache())
#drive_find(pattern = 'vbp', n_max = 20)

drive_download(file = as_id('1NFN__acvMtrNUji4H9eZ35rUnx11xECI'), overwrite = TRUE)
drive_download(file = as_id('1nkE1Mti-O2KiyZ-U4zka_0x3oI7bVnra'), overwrite = TRUE)


#IMPORTAR DATOS A R
empleo_empresas_df <- import_list('empleo y empresas.xlsx')

test <- empleo_empresas_df$`empleados caba` %>%
  gather(key = 'fecha', value = 'empleados', -(1:4)) %>% 
  clean_names() %>%
  mutate(fecha = excel_numeric_to_date(as.numeric(fecha)))
