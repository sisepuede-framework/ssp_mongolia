rm(list=ls())

output.folder <- "ssp_modeling/ssp_run/sisepuede_run_2025-06-20T20;16;38.965577/sisepuede_run_2025-06-20T20;16;38.965577/sisepuede_run_2025-06-20T20;16;38.965577_output_database"

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

write.csv(data_all,'ssp_modeling/ssp_run/2025-06-20/sisepuede_mongolia_run.csv',row.names=FALSE)
write.csv(primary.file,'ssp_modeling/ssp_run/2025-06-20/ATTRIBUTE_PRIMARY.csv',row.names=FALSE)
write.csv(strategy.file,'ssp_modeling/ssp_run/2025-06-20/ATTRIBUTE_STRATEGY.csv',row.names=FALSE)