# Revised by June to handle properly formatted .ini files

library(ini)
filename <- 'C:/Database/Calculation_Procedures/TraceAnalysis_ini/BBS/BBS_ThirdStage.ini'
yearsToProcess <- 2
yrs <- c(2023,2024)
ini_file <- read.ini(filename, encoding = getOption("encoding"))

## A lot of what is below does *not* need to be done here, it can be called directly in the stage 3 code

# Year the site was established
estYear <- strtoi(ini_file$Metadata$estYear)
siteID <- ini_file$Metadata$siteID


# Specify range of years to process
stYear <- min(yrs)-yearsToProcess+1
# Check if year stYear exists. If not, set it to estYear
if(stYear<estYear){
  stYear <- estYear
}

edYear <- yrs
years_REddyProc <- unique(c(stYear, edYear)) # Specify the number of years to use in REddyProc ustar filtering, gap-filling and partitioning (use all by default)
years_RF <- unique(c(stYear, edYear)) # Specify the number of years to use in RF gap-filling (use all by default)


# There are a few iterations of this variable, maybe it isn't necessary
vars <- unlist(unname(ini_file$REddyProc_In[!(names(ini_file$REddyProc_In) %in% c('Year', 'DoY', 'Hour'))]))


# Specify site location
lat <- 	as.double(ini_file$Metadata$lat)  # Site latitude
long <- as.double(ini_file$Metadata$long) # Site longitude
TimeZoneHour <- as.integer(ini_file$Metadata$TimeZoneHour) # time offset (in PST) from UTC 


# Specify time vector name
tv_input <- ini_file$Metadata$tv_input


export <- tv_input <- ini_file$Metadata$tv_input # 0/1 to save a csv file of the data, 0 otherwise

# Specify variables only relevant variables for input into REddyProc
col_order <-unlist(unname(ini_file$REddyProc_In))

# Specify variable names in REddyProc
var_names <- names(ini_file$REddyProc_In)

# #Note that units should be the following:
# #UNITS<-list('-','-','-','umol_m-2_s-1','umol_m-2_s-1','Wm-2','Wm-2','nmol_m-2_s-1','Wm-2','degC','%','hPa','ms-1')

# Define variables to save in third stage
vars_third_stage_REddyProc <- names(ini_file$REddyProc_Out)
vars_names_third_stage <- unlist(unname(ini_file$REddyProc_Out))

# Random Forest gap-filling
# Gap-filling FCH4
fill_RF_FCH4 <- ini_file$GapFill_FCH4$fill_RF_FCH4 # 0 (no) or 1 (yes) to fill FCH4 and long gaps with RF from Kim et al., 2019 GCB
level_RF_FCH4 <- ini_file$GapFill_FCH4$level_RF_FCH4 # which folder you are loading variables from for RF gap-filling (not this should typically remain unchanged unless there's a specific reason to load data from another folder)

# variable we need for FCH4 gap-filling (if implementing)
# df includes FCH4 and predictor variables.
# FCH4 should be quality controlled. Other variables should be fully gap-filled (maybe gap-fill long gaps for CO2 fluxes first!! ADD LATER)
predictors_FCH4 <- names(ini_file$GapFill_FCH4_Predictors[ini_file$GapFill_FCH4_Predictors==1])
plot_RF_results <- ini_file$GapFill_FCH4$plot_RF_results
vars_third_stage_RF_FCH4 <- ini_file$GapFill_FCH4$vars_third_stage_RF_FCH4

# Gap-filling long gaps with RF (add later!!)

# This is a pretty clunky procedure.  Why not just copy every variable from 2 to 3 and deal with a few extras?
copy_vars <- (ini_file$CopyVars[ini_file$CopyVars==1])

# # Add R functions to for: 'aerodynamic_resistance_momentum', 'aerodynamic_resistance_scalar','surface_conductance','specific_humidity'
