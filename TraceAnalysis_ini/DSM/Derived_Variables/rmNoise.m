function cleanedData = rmNoise(clean_tv,originalData,instDate)
% Remove data before the sensor was installed

% Memo:   This script was used to delete noise data
%         Blocking off values before installation (Noise readings 
%         after installing CR1000 but before putting on the sensors)

%instDate: should be a 'datenum'

% Revisions:
%
% Feb 4, 2023 (Tzu-Yi)
%    - added memo 

ind_delete=find(clean_tv<=instDate); % uninstalled
originalData(ind_delete,:)=NaN;
cleanedData=originalData;