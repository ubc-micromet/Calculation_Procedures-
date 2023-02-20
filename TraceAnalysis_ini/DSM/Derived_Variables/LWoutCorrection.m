% LW_OUT_1_1_1 correction:

% Period: 2021-Oct-08 to 2022-Oct-12

% Memo: Because of a fault in the CR1000 program, the LW_OUT_1_1_1 readings
%       were wrong. 

%       Measurements before 2022-Jun-07:
%       (1)Use DSM(SW_in, SW_out, LW_in, G_avg, Ts_5cm_avg) to get LW_OUT
%       (2)Use corrected LW_OUT to get NETRAD.

%       Measurements after 2022-Jun-07:
%       (1)Use RBM(LW_OUT) → DSM(LW_OUT)
%       (2)Use RBM(NETRAD) → DSM(NETRAD)

% Period:
% 2022/10/12 11:00 - 2023/02/15 12:00 : Used to calculate fitting coefficients

% 2021/10/08 15:00 - 2022/06/07 19:30 : Estimated by DSM(SWin, SWout, LWin, G, TS-5cm)
% 2022/06/07 20:00 - 2022/10/12 11:00 : Gap-filled with RBM data

%% Define time info
t1=datenum(2021,10,8,15,0,0);
t2=datenum(2022,6,7,19,30,0);
t3=datenum(2022,10,12,11,0,0);

p1=find(clean_tv>=t1 & clean_tv<t2);  % 2021-Oct-08 ~ 2022-Jun-07
p2=find(clean_tv>=t2 & clean_tv<=t3); % 2022-Jun-07 ~ 2022-Oct-12

%% Call coefficients of fitting models
   % coefficients were calculated individually and copied to here.

coe_1 = [235.5937, 0.1427, -0.1694, 0.2550, 1.3807, 3.9517]; 
                          % model_1: DSM(SWin, SWout, LWin, G, TS_1)➜DSM(LWout)
coe_2 = [1.1917, 0.8632]; % model_2: (NetRad)RBM➜DSM
coe_3=[-25.9254,1.0691];  % model_3: (LWo)RBM➜DSM

%% Correct wrong data
% p1: DSM(SWin, SWout, LWin, G, TS-5cm) ➜ DSM(LWo) ➜ DSM(NetRad)
    X=[SW_IN_1_1_1(p1), SW_OUT_1_1_1(p1), LW_IN_1_1_1(p1), TS_1(p1), G_1(p1)];
    LW_OUT_1_1_1(p1)=coe_1(1)+X*coe_1(2:end)';
    NETRAD_1_1_1(p1)=SW_IN_1_1_1(p1)-SW_OUT_1_1_1(p1)+LW_IN_1_1_1(p1)-LW_OUT_1_1_1(p1);

% p2: RBM ➜ DSM
    % (1) NETRAD_1_1_1    
        X=RBM_NETRAD_1_1_1(p2);
        NETRAD_1_1_1(p2)=coe_2(1)+X*coe_2(2:end)';
        
    % (2) LW_OUT_1_1_1
        X=RBM_LW_OUT_1_1_1(p2);
        LW_OUT_1_1_1(p2)=coe_3(1)+X*coe_3(2:end)';
