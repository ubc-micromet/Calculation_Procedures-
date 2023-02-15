function shiftedData = shiftMyData(clean_tv,originalData)
% Time Shift Correction:

% Period: 2021-Aug-25 ~ 2021-Nov-11

% Memo:   Due to a wrong setting of 'DataInterval' in the CR1000 program at DSM, 
%         (we set it as 30 min at the beginning, but it should be 60sec)
%         the timestamps during this period in BIOMET table were lagged by 30min.

% Revisions:
%
% Feb 4, 2023 (Tzu-Yi)
%    - added memo (details about timestamp lag problem)
%    - removed the 'run_std_dev' part from this script.


tsc=find(clean_tv<=datenum(2021,11,11,09,30,0)); 
originalData(tsc(1:end-1)) = originalData(tsc(2:end));
shiftedData=originalData;