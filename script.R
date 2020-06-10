library(tidyverse)
library(rio)
library(googledrive)
library(janitor)

drive_auth('nelsonshilman.gcba@gmail.com', cache = gargle::gargle_oauth_cache())
#drive_find(pattern = 'vbp', n_max = 20)

drive_download(file = as_id('1NFN__acvMtrNUji4H9eZ35rUnx11xECI'), overwrite = TRUE)
drive_download(file = as_id('1nkE1Mti-O2KiyZ-U4zka_0x3oI7bVnra'), overwrite = TRUE)


#IMPORTAR DATOS A R
empleo_empresas_df <- import_list('empleo y empresas.xlsx')




empleo_empresas_df$`empleados caba` <- empleo_empresas_df$`empleados caba` %>%
  gather(key = 'periodo', value = 'empleados', -(1:3)) %>% 
  clean_names() %>% 
  mutate(periodo = excel_numeric_to_date(as.numeric(periodo)))

empleo_empresas_df$`empleadores caba` <- empleo_empresas_df$`empleadores caba` %>% 
  gather(key = 'periodo', value = 'empleadores', -(1:3)) %>% 
  clean_names() %>% 
  mutate(periodo = excel_numeric_to_date(as.numeric(periodo)))

empleo_empresas_df$`empleo nac` <- empleo_empresas_df$`empleo nac` %>% 
  gather(key = 'year', value = 'empleados', -c(1,2)) %>% 
  clean_names() %>% 
  mutate_at(.vars = c(1,4), as.numeric)

empleo_empresas_df$`establecimiento nac` <- empleo_empresas_df$`establecimiento nac` %>% 
  gather(key = 'year', value = 'establecimientos', -c(1,2)) %>% 
  clean_names() %>% 
  mutate_at(.vars = c(1,4), as.numeric)

  
vbp_vab_pimp <- import_list("vbp, vab y pimp.xlsx")




