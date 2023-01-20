function shiftedData = shiftMyData(clean_tv,originalData,wlen,thres)
				% Time Shift Correction
				tsc=find(clean_tv<=datenum(2021,11,11,09,30,0)); 
				originalData(tsc(1:end-1)) = originalData(tsc(2:end));
				originalData = run_std_dev(originalData,clean_tv,wlen,thres);'