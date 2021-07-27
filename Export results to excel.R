# Export your data to excel for easy analysis 
## You can also analyse your data in R, this script is only necessary if you feel uncomfortable with R.  


# Define where you stored your data and where your new Excel file should be stored.
file_path_results <- "/Users/timnoahkempchen/Library/Mobile Documents/com~apple~CloudDocs/Uni/Bachelorarbeit /Bachelorarbeit /Experiments/Experiment 16/PHICAL/Results" 
file_path_excel <- "/Users/timnoahkempchen/Library/Mobile Documents/com~apple~CloudDocs/Uni/Bachelorarbeit /Bachelorarbeit /Experiments/Experiment 16/PHICAL/Results//Results.xlsx"

# load required packages (if "pacman" is already installed ignore line 10)
install.packages("pacman")
require(pacman)
pacman::p_load(dplyr, readr, writexl)

df <- list.files(path=file_path_results, full.names = TRUE) %>% 
  lapply(read_csv) %>% 
  bind_rows 

df$X1 <- NULL

write_xlsx(df,file_path_excel)
