# Trace Analysis Ini Files - Instructions and guidelines

## First Stage

In the first stage of cleaning the idea is to clean up the data so we can keep only the best measured values (data points) for each sensor. No interpolation is done at this stage so any removed points will not be gap-filled. If the researcher is looking for the best measurements from a particular sensor, this is the data that they want.

The first stage cleaning provides the following features:

1. Selects traces that are needed for future data analysis. Not all the measured variables from a site need to be here - only the ones that will be used in future analysis or that’s needed to improve cleaning.
2. File names from the database can be renamed here. The trace name does not have to be the same as the file name from the database.
3. The original values can be altered (calibrations can be applied, units can be changed).
4. Basic filtering can be done: 
  * Values can be removed if they exceed minMax thresholds. 
  * Values can be clamped to the thresholds if they exceed clampedMinMax values. 
7. This stage creates dependencies between different traces. If one trace gets some points removed here, all its dependent traces will have those points removed too. 

Introduction:
All traces must be enclosed in [Trace] and [End] blocks.
All assignments can be on multiple lines, but should be enclosed in single quotes.
Comments must begin with a percentage sign,%.
The partial path must be included with the inputFileName, when you locate the raw data trace in the database. (Using biomet_path only returns the path: 'year/site/measType/')
Necessary fields are: variableName, inputFileName, measurementType, units, title, and minMax.
All fields must be in Matlab format
All assignments must be to strings in single quotes, or numeric expressions (ex: threshold_const = 6, threshold_const = [6],variableName = 'Some Name')	

<img src="images/first stage.png">

Grayed out parameters are legacy properties that should not be used in the new ini files. They can be left in or removed from the old ones.

### Properties

| Field      | Description |
| ----------- | ----------- |
| Header/Comments      | “%” character indicates the beginning of a comment. Program will not process any characters that follow “%”. Use comments to add information and to better document the site. Each line of the ini file can be followed by a comment. Comments were removed from the above example to improve readability of this document. Refer to the example ini file at the end of this document. (link here FirstStage.ini file from DSM site)       |
| Site_name   | Name of the site. Any text can go here.        |
| SiteID      | This is the name attributed to the site in the database (e.g., DSM or BB1). |
| Difference_GMT_to_local_time | Time difference between GMT time, that database is kept in, and the standard time at the site location (for PST this is +8). |
|[Trace] | Marks the beginning of a new variable. The section has to end with the keyword <[END]>.|
| variableName | Name of variable for first stage. The variable with this name created here will show up in the sub-folder “Clean” under the same folder where the original database file came from. In the Micromet Lab, these should follow the AmeriFlux naming convention. |
| title | Descriptive title for plots/visualization.|
| originalVariable| This is an example of adding an optional field to a trace that can be used by an advanced user. Here it’s set to be the same as the variableName. Currently, this particular field is not used for generic processing. |
|inputFileName |{‘file name’} - The name of the database file that contains data for this trace. The brackets are mandatory.<br /> The file name can include folder(s): ‘Met/Tair’. The folder paths are relative to the main site path (‘./database/yyyy/siteID’) so the above example translates into this path:   ‘./database/yyyy/siteID/Met/Tair’<br />Over the lifetime of a site, the data logger programs sometimes change and a sensor measurement that was assigned to a variable may change. To allow for different variable names over the site history the inputFileName can be given as: {‘fileName1’,’fileName2’}. In that case the parameter inputFileName_dates also needs to be present in the [Trace]...[END] structure.<br /> Advanced: If there is a need to load up a data file from another site, the path can be constructed in this way: ‘../../siteID2/dataFolder’. The ‘../../’ moves the path pointer up to ‘/database/yyyy’ and from there ‘siteID2/dataFolder’ takes the program to that folder.|
|inputFileName_dates |[ datenum_start1 datenum_end1; datenum_start2 datenum_end2] - starts and ends of data periods for each of the inputFileNames. <br />If there are multiple inputFileNames ( {‘fileName1’, ‘fileName2} ) then the program needs to know the time periods where the data assigned to the variableName should come from ‘fileName1’ and when from ‘fileName2’. In that case, this field is mandatory.<br /> If inputFileName contains only one file name, this parameter is optional. It is still a good practice to use it anyway.<br /> The last ‘datenum_end’ is usually set far into the future: datenum(2999,1,1).|
|measurementType|‘char’ - Mandatory parameter that sets the input and output trace folders. The input folder defaults to: "siteID/measurementType/inputFileName". If relative paths are used they "assume" that the current folder is "siteID/messurementType" so the relative path is referenced to that. The output folder for the cleaned trace is always "siteID/measurementType/clean". <br />Note: If the measurementType is missing (empty) the data will be saved to "siteID/clean/variableName" which is wrong.|
|units|‘char’ - Units for this trace|
|Instrument|Instrument type|
|instrumentSN|Instrument SN. ** check if this parameter can be time-stamped. If not it’s not very useful**|
|calibrationDates|NOT USED|
|loggedCalibration|Used together with currentCalibration. When a trace’s linear calibrations need to be changed, these coefficients are used to convert the trace values from engineering units to its original/raw units. Then the correct calibration coefficients (currentCalibration) are used. This can also be used to change the units. The format is [gain offset startDatenum endDatenum], where startDatenum and endDatenum refer to the time span that this particular set of coefficients was used.<br /> Note: all calibration values need to be in the same line (no line-breaks in the ini file are allowed)!  This can be very inconvenient. Fix it maybe?|
|currentCalibration|Correct(ed) linear calibration coefficients. Used together with loggedCalibrations (see its notes for more details). |
|comments|Any comments.|
|minMax|[min max] - Minimum and maximum thresholds for filtering. The values outside of this range will be set to NaN|
|clamped_minMax|[cMin cMax] Similar to minMax but instead of setting the point outside the range to NaN, it sets their value to the cMin or cMax. (e.g., RH: [0 100]).<br />Note: this property is not mandatory. When used, please make sure that the minMax property boundaries are wider than the boundaries of clamped_minMax because the minMax property is applied first (e.g. RH: minMax = [-1 110], clamped_minMax=[0 100]).|
|zeroPt|In the legacy Biomet database, 0 was used to indicate missing data. The cleaning program would compare every value in the trace and, if it was equal to zero, it would replace it with a NaN. This parameter (zeroPt) was used to change this behavior so that the program looks for a different number. Many programs nowadays use -9999 to indicate bad/missing data points.|
|interpolationType|NOT USED. Indicates which type of interpolation should be used. The default is Matlab’s ‘interp1’. Remove from ini files where feasible.|
|interpLength|NOT USED (same as above)|
|plotBottomRight|plot specifications used for visualization/manual cleaning program (to be implemented) |
|plotBottomLeft |plot specifications used for visualization/manual cleaning program (to be implemented) |
|dependent|Filter dependent variables based on specified trace. It can have multiple dependents that need to be separated by commas: ‘trace1,trace2,trace3’.<br />Note that this needs to be sorted manually. For example, when using the LI-7200 pump, all the traces that depend on the LI-7200 are dependent on the pump trace. So, for the pump: dependent = ‘CO2,H2O’. Then the CO2 trace should have dependent = ‘FC…’ and so on. Avoid circular references: CO2: dependent = ‘FC’, FC: dependent = ‘CO2’.|
|[End]|Marks the end of the trace properties section.|

**Note:**
<br />
Other properties that user wants to use later on in their own programs (or in the “Evaluate” statements in Second and Third stage cleaning ini files) can be added to each of the traces. The function that processes the ini files (read_ini_files.m) will add the property (and its assigned value) to the trace structure but the rest of the Trace Analysis programs will ignore it. The user can then parse the trace info in their own programs (or within “Evaluate” statements) and take advantage of this feature.<br />

## Second Stage
While the first stage cleaning provides the best sensor measurement, the second stage focuses on creating the best measured data for the particular property.  Example would be having multiple sensors measuring air temperature at one height. The second stage would create the best (the highest precision/accuracy, the fewest missing points) data trace (“Tair_best”). At the end of this stage the desired output is the best measured data trace (no gap filling for flux data).

The main features:
1. Combining multiple sensor measurements into one trace. This can be done in different ways or their combinations.<br />
  a. Averaging multiple sensors to remove variability.<br />
  b. Using one sensor as the best (most accurate value) and using the other sensor(s) only to fill in the missing values.<br />
    &ensp; &ensp; i. A relationship can be created between the “best” sensor and its “replacement” and that relationship can be applied to the 
    &ensp; &ensp;&ensp;&ensp;“replacement” values to improve the accuracy.<br />
  c. Using the sensors from another near-by site to fill in the missing values at the current site.<br />
2. More complex user-defined processing can be applied to the trace using the “Evaluate” option. User written Matlab functions can be called from this statement. Multiple Matlab statements can be called from within the “Evaluate” string. Some rules for formatting apply here (see the existing SecondStage ini file for details and examples).

<img src="images/second stage.png">

## Third Stage

This is the final stage of the cleaning process. The outcome of this stage are fully gap-filled data traces that can be used to calculate annual totals for fluxes and other variables. 

More details coming soon!



