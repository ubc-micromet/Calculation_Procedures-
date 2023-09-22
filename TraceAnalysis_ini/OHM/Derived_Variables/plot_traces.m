Site = 'YOUNG';

dbPath = '/Users/darianng/Documents/MSc_Geography/Biomet_cleaning/Local_copies';

% varList = ["WD_1_1_1","WS_1_1_1","USTAR","W_SIGMA","TA_1_1_1","RH_1_1_1",...
%           "SW_IN_1_1_1","SW_OUT_1_1_1","LW_IN_1_1_1","LW_OUT_1_1_1",...
%           "NETRAD_1_1_1","PPFD_IN_1_1_1","PA_1_1_1", "P_1_1_1",...
%           "TS_1","TS_2","TS_3","NEE","FC","H","LE","FCH4"];

varList = ["NEE_U50_f","FCH4_U50_f","LE_U50_f"];

x = read_bor(['/Users/darianng/Documents/MSc_Geography/Biomet_cleaning/Local_copies/2022/' Site '/Flux/Clean_tv'],8);
dates = datestr(x);
tickLocations = 1:length(x)/10:length(x);
tickDates = dates(tickLocations,:);
i = 1;
for var = varList
%     y = read_bor(char(strcat(dbPath,['/2022/' Site '/Clean/ThirdStage/'],var)));
    y = read_bor(char(strcat(dbPath,['/2022/' Site '/Clean/ThirdStage_REddyProc_RF_Fast/'],var)));
    figure(i)
    plot(y)
    xticks(1:length(x)/10:length(x));
    xticklabels(tickDates);
    title(var);
    i = i+1;
end
disp(['Number of plots: ' num2str(length(varList))])