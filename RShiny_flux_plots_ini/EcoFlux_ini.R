# variables/paths to edit to run 'flux_shiny_app.R'

# Specify the path to your database
main_dir <- "/Users/saraknox/Code/local_data_cleaning/Projects/EcoFlux/Database"

# Path for met/flux variables to display
basepath <- main_dir
level <- c("Clean/ThirdStage") #Update to third stage
tv_input <- "clean_tv" # MAKE SURE tv is in folder

# Path to csv file with units
UnitCSVFilePath <- '/Users/saraknox/Code/Biomet.net/R/RShiny_flux_plots/flux_variables.csv'

# path to shiny app folder
arg <- '/Users/saraknox/Code/Biomet.net/R/RShiny_flux_plots/'

# provide names for incoming shortwave radiation and incoming PPDF
var_rad <- c('SW_IN_1_1_1', 'PPFD_IN_1_1_1') 

# path and file name of site coordinates - update for your site
coordinatesXLSXFilePath <- '/Users/saraknox/Code/local_data_cleaning/Projects/EcoFlux/Database/Calculation_Procedures/RShiny_flux_plots_ini/site_coordinates_EcoFlux.xlsx'

