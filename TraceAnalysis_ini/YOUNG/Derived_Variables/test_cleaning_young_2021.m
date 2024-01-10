%% This program is used to clean (erase) the data that was mistakenly included
%  in the YOUNG 2021 data base. The data before the sensors were installed at 
%  the site on May 26, 2021 was from the system testing period on the lawn
%  by Pascal's office.
%
% Cleaning done on Jan 4, 2024. There is no need to run it again.
%
% Jan 4, 2024 (Zoran)
%

% -------
return
% -------

%pathIn = 'E:\Junk\database\2021\Young\Flux';
pathIn = 'p:\database\2021\Young\Flux';
s=dir(pathIn);
tv = read_bor(fullfile(pathIn,'Clean_tv'),8);
tv_dt = datetime(tv,'ConvertFrom','datenum');
indBadData = find(tv_dt<'May 26, 2021');
for cntFiles = 1:length(s)
    if ~s(cntFiles).isdir
        fileName = s(cntFiles).name;
        if s(cntFiles).bytes < 100000
            dataIn = read_bor(fullfile(pathIn,fileName));
            dataIn(indBadData) = NaN;
            save_bor(fullfile(pathIn,fileName),1,dataIn);
        end
    end
end


