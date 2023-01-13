# ini file questions

## General

* What format is the data stored in?  

## Stage 1

* BB1/2 - wind speed by RM Young?
* Serial #s and calibrations?
* consistency in min/max/clamping
* Which variables to bring over from other sites
    * ECCC - BB for BB sites? Others for RBM/DSM?
    * Radiation from nearest micromet sites? Totem?
* Naming conventions for variables- e.g. TA_1_1_1
    * Var_Position_Level_???

## Stage 2

## clean_tv

* What is it?

## Time Shift Correction

* Apply to BB sites?

## calc_avg_trace()

* Only needed when there are multiple variables right?
    * Otherwise just pass thru - ie.: ```Evaluate = 'FCH4 = FCH4;'``
* avg_period == -1
    * Does linear regression?  shouldn't be applied to wind direction right?
    * ```wind_dir = calc_avg_trace(clean_tv,wind_dir,WD_ECCC,-1);```
* For TA_1_2_1 (e.g., 30 cm at BB1) should we be running using TA_ECCC?
* For TA, precip, etc. fill with both BB sites + EC sites?
* Radiation
    * Use for SW/LW incoming - filling w/ nearest site?
        * but not outgoing?
    * For NETRAD_1_1_1
        * Evaluate = 'NETRAD_1_1_1 = NETRAD_1_1_1; ?
        * Or re-cacluate as sum of components?

## run_std_dev()

* Variables we do/don't want it applied to?
    * Do: TA, RH, etc.
    * Don't: precip?
    * What about fluxes?
        * Is this saved for stage 3?
* Better than Median Absolute Deviation?

## Variables

* Do we want VPD_1_2_1?