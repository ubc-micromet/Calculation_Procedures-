# ini file questions

# Meeting General Notes

* Main script in task scheduler

* What format is the data stored in?
    * Data format - IEEE4 4-byte single precision 
    * Docs list?
    * Check the program for outputs when questions arrise
    * Easy way to read/view files?
    * guiPlotTraces - matlab

* Met folder
    - 5min,30min?

* clean_tv Time vector file
    * 30 minute time vector file - Local Standard Time

* Derived variables - custom scripts on per-site basis
    - break values

## Stage 1

* BB1/2 - wind dir by RM Young?
    * MET_Young_WS_WVc1 - pass thru to stage 2 then calc

* Serial #s and calibrations?

* Check/ensure consistency in min/max/clamping
    * e.g. WTD - where is zero level?

* Which variables to bring over from other sites
    * ECCC - BB for BB sites? Others for RBM/DSM?
    * Radiation from nearest micromet sites? Totem?

* Naming conventions for variables- e.g. TA_1_1_1
    * Var_Position_Level_???

# Stage 2

## Clamping

* Min/max consistency between sites

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
    * Think about which to apply
* Better than Median Absolute Deviation?

## Variables/Naming

* Why change soil temp conventions?
    * e.g., TS_1_1_1 to TS_1 ... etc?

* Do we want VPD_1_2_1?

* NEE calculation
    * Should it be and "or" statement instead of an "and"?
    * Storage corrected
    
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
    * guiPlotTraces

