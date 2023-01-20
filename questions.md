# ini file questions

## General

* What format is the data stored in?  

## Stage 1

* BB1/2 - wind dir by RM Young?
* Serial #s and calibrations?
* Check/ensure consistency in min/max/clamping
    * e.g. WTD - where is zero level?
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
* Soil parameters - fill with equivalent from BB1/2

## run_std_dev()

* Variables we do/don't want it applied to?
    * Do: TA, RH, etc.
    * Don't: precip?
    * What about fluxes?
        * Is this saved for stage 3?
* Better than Median Absolute Deviation?

## Variables/Naming

* Why change soil temp conventions?
    * e.g., TS_1_1_1 to TS_1 ... etc?

* Do we want VPD_1_2_1?

* NEE calculation
    * Should it be and "or" statement instead of an "and"?
    
```MATLAB
NEE = sum([FC,SC],2,''omitnan'');
NEE(all(isnan(FC)&isnan(SC),2)) = NaN;
```

* Add a NME variable?

```MATLAB
NME = sum([FCH4,SCH4],2,''omitnan'');
NME(all(isnan(FCH4)&isnan(SCH4),2)) = NaN;
```

## Plotting outputs?

* What matlab command lets us plot the outputs from each stage?

