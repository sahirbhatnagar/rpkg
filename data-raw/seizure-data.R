######################################
# R Source code file for creating dataset to be included in the rpkg package
# data taken from:
# MASS package
# Author: Sahir Bhatnagar
# Created: May 27, 2019
# Updated:
#####################################

# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(magrittr, dplyr, usethis, data.table, here)

# clean data ----
epil <- read.csv(here::here("data-raw","epil.csv"))
DT <- epil %>% as.data.table
DT.base <- DT %>% distinct(subject, .keep_all = TRUE)
DT.base[,`:=`(period=0,y=base)]
DT.epil <- rbind(DT, DT.base)
setkey(DT.epil, subject, period)
DT.epil[,`:=`(post=as.numeric(period>0), tj=ifelse(period==0,8,2))]
df_epil <- as.data.frame(DT.epil) %>% dplyr::select(y, trt, post, subject, tj)

# write data in correct format to data folder ----
usethis::use_data(df_epil, overwrite = TRUE)