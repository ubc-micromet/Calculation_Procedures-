ind_delete = find(clean_tv<datenum(2021,9,4,0,30,0)); 
TA_ECCC(ind_delete) = NaN;
TA_1_1_1 = calc_avg_trace(clean_tv,TA_1_1_1,TA_ECCC,-1);

% Time Shift Correction
tsc=find(clean_tv<=datenum(2021,11,11,09,30,0)); 
TA_1_1_1(tsc(1:end-1)) = TA_1_1_1(tsc(2:end));

% Remove spikes
wlen=24; % data points used in each window (unit: 30min)
thres=4; % ratio of std for lower and upper bound

TA_1_1_1 = run_std_dev(TA_1_1_1,clean_tv,wlen,thres);