rm(list=ls())

output.folder <- "/home/fabian_fuentes/repos/ssp_mongolia/ssp_modeling/ssp_run/mongolia_sisepuede_run_2025-06-22T11;05;26.207924/sisepuede_run_2025-06-22T11;05;26.207924/sisepuede_run_2025-06-22T11;05;26.207924_output_database"

input.file <- read.csv(paste0(output.folder,"/MODEL_INPUT.csv"))
output.file <- read.csv(paste0(output.folder,"/MODEL_OUTPUT.csv"))

primary.file <- read.csv(paste0(output.folder,"/ATTRIBUTE_PRIMARY.csv"))
head(primary.file)

strategy.file <- read.csv(paste0(output.folder,"/ATTRIBUTE_STRATEGY.csv"))
head(strategy.file)

data_all <- merge(output.file, input.file, how="left", by=c("primary_id","time_period","region"))

data_all$time_period <- as.numeric(data_all$time_period)

data_all <- data_all[order(data_all$primary_id,
                           data_all$time_period), ]

dir.output <- "ssp_modeling/ssp_run/2025-06-22"

write.csv(data_all,paste0(dir.output,'/sisepuede_mongolia_run.csv'),row.names=FALSE)
write.csv(primary.file,paste0(dir.output,'/ATTRIBUTE_PRIMARY.csv'),row.names=FALSE)
write.csv(strategy.file,paste0(dir.output,'/ATTRIBUTE_STRATEGY.csv'),row.names=FALSE)
