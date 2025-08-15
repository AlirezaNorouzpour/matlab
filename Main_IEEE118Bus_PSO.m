close all
clear all
clc
global basemva accuracy maxiter Initial_Loss Total_initiacost TS_initial busdata_initial linedata_initial cost_initial
global cost_initial gendata_initial Initial_VD Initial_VSM Islanddata Totalload busdata24 r1 c1 r2 c2 Initial_EENS Initial_VSI
global Initial_plsf Ifault_initial
basemva = 100;  accuracy = 0.001;  maxiter = 20;
fprintf('\n ====================================================================================== \n ')
fprintf('\n Case Study : IEEE118BUS Network ')
fprintf('\n ================================= Expected Results =================================== \n ')
warning off


  % BUs No. load at BUS
%      P(KW)   Q(KVAR)    
m=[ 1	0	0	
    2	133.84	101.14	
    3	16.214	11.292	
    4	34.315	21.845	
    5	73.016	63.602	
    6	144.2	68.604	
    7	104.47	61.725	
    8	28.547	11.503	
    9	87.56	51.073	
    10	198.2	106.77	
    11	146.8	75.995	
    12	26.04	18.687	
    13	52.1	23.22	
    14	141.9	117.5	
    15	21.87	28.79	
    16	33.37	26.45	
    17	32.43	25.23	
    18	20.234	11.906	
    19	156.94	78.523	
    20	546.29	351.4	
    21	180.31	164.2	
    22	93.167	54.594	
    23	85.18	39.65	
    24	168.1	95.178	
    25	125.11	150.22	
    26	16.03	24.62	
    27	26.03	24.62	
    28	594.56	522.62	
    29	120.62	59.117	
    30	102.38	99.554	
    31	513.4	318.5	
    32	475.25	456.14	
    33	151.43	136.79	
    34	205.38	83.302	
    35	131.6	93.082	
    36	448.4	369.79	
    37	440.52	321.64	
    38	112.54	55.134	
    39	53.963	38.998	
    40	393.05	342.6	
    41	326.74	278.56	
    42	536.26	240.24	
    43	76.247	66.562	
    44	53.52	39.76	
    45	40.328	31.964	
    46	39.653	20.758	
    47	66.195	42.361	
    48	73.904	51.653	
    49	114.77	57.965	
    50	918.37	1205.1	
    51	210.3	146.66	
    52	66.68	56.608	
    53	42.207	40.184	
    54	433.74	283.41	
    55	62.1	26.86	
    56	92.46	88.38	
    57	85.188	55.436	
    58	345.3	332.4	
    59	22.5	16.83	
    60	80.551	49.156	
    61	95.86	90.758	
    62	62.92	47.7	
    63	478.8	463.74	
    64	120.94	52.006	
    65	139.11	100.34	
    66	391.78	193.5	
    67	27.741	26.713	
    68	52.814	25.257	
    69	66.89	38.713	
    70	467.5	395.14	
    71	594.85	239.74	
    72	132.5	84.363	
    73	52.699	22.482	
    74	869.79	614.775	
    75	31.349	29.817	
    76	192.39	122.43	
    77	65.75	45.37	
    78	238.15	223.22	
    79	294.55	162.47	
    80	485.57	437.92	
    81	243.53	183.03	
    82	243.53	183.03	
    83	134.25	119.29	
    84	22.71	27.96	
    85	49.513	26.515	
    86	383.78	257.16	
    87	49.64	20.6	
    88	22.473	11.806	
    89	62.93	42.96	
    90	30.67	34.93	
    91	62.53	66.79	
    92	114.57	81.748	
    93	81.292	66.526	
    94	31.733	15.96	
    95	33.32	60.48	
    96	531.28	224.85	
    97	507.03	367.42	
    98	26.39	11.7	
    99	45.99	30.392	
    100	100.66	47.572	
    101	456.48	350.3	
    102	522.56	449.29	
    103	408.43	168.46	
    104	141.48	134.25	
    105	104.43	66.024	
    106	96.793	83.647	
    107	493.92	419.34	
    108	225.38	135.88	
    109	509.21	387.21	
    110	188.5	173.46	
    111	918.03	898.55	
    112	305.08	215.37	
    113	54.38	40.97	
    114	211.14	192.9	
    115	67.009	53.336	
    116	162.07	90.321	
    117	48.785	29.156	
    118	33.9	18.98];


                                           
%  line No. sending  recieving   resistance(ohm)     reactance(ohm)
%             node    node                                               
l=[    	1       1	2	0.036	0.01296	
	2       2	3	0.033	0.01188	
	3       2	4	0.045	0.0162	
	4       4	5	0.015	0.054		
        5	5	6	0.015	0.054		
        6	6	7	0.015	0.0125		
	7	7	8	0.018	0.014		
	8	8	9	0.021	0.063		
	9	2	10	0.166	0.1344		
	10	10	11	0.112	0.0789		
	11	11	12	0.187	0.313		
	12	12	13	0.142	0.1512		
	13	13	14	0.18	0.118		
	14	14	15	0.15	0.045		
	15	15	16	0.16	0.18		
	16	16	17	0.157	0.171		
	17	11	18	0.218	0.285		
	18	18	19	0.118	0.185		
	19	19	20	0.16	0.196		
	20	20	21	0.12	0.189		
	21	21	22	0.12	0.0789		
	22	22	23	1.41	0.723	
	23	23	24	0.293	0.1348	
	24	24	25	0.133	0.104	
	25	25	26	0.178	0.134	
	26	26	27	0.178	0.134	
	27	4	28	0.015	0.0296	
	28	28	29	0.012	0.0276	
	29	29	30	0.12	0.2766	
	30	30	31	0.21	0.243	
	31	31	32	0.12	0.054	
	32	32	33	0.178	0.234	
	33	33	34	0.178	0.234	
	34	34	35	0.154	0.162	
	35	30	36	0.187	0.261	
	36	36	37	0.133	0.099	
	37	29	38	0.33	0.194	
	38	38	39	0.31	0.194	
	39	39	40	0.13	0.194	
	40	40	41	0.28	0.15	
	41	41	42	1.18	0.85	
	42	42	43	0.42	0.2436	
	43	43	44	0.27	0.0972	
	44	44	45	0.339	0.1221	
	45	45	46	0.27	0.1779	
	46	35	47	0.21	0.1383	
	47	47	48	0.12	0.0789	
	48	48	49	0.15	0.0987	
	49	49	50	0.15	0.0987	
	50	50	51	0.24	0.1581	
	51	51	52	0.12	0.0789	
	52	52	53	0.405	0.1458	
	53	53	54	0.405	0.1458	
	54	29	55	0.391	0.141	
	55	55	56	0.406	0.1461	
	56	56	57	0.406	0.1461	
	57	57	58	0.706	0.5461	
	58	58	59	0.338	0.1218	
	59	59	60	0.338	0.1218	
	60	60	61	0.207	0.0747	
	61	61	62	0.247	0.8922	
	62	1	63	0.028	0.0418	
	63	63	64	0.117	0.2016	
	64	64	65	0.255	0.0918	
	65	65	66	0.21	0.0759	
	66	66	67	0.383	0.138	
	67	67	68	0.504	0.3303	
	68	68	69	0.406	0.1461	
	69	69	70	0.962	0.761	
	70	70	71	0.165	0.06	
	71	71	72	0.303	0.1092	
	72	72	73	0.303	0.1092	
	73	73	74	0.206	0.144	
	74	74	75	0.233	0.084	
	75	75	76	0.591	0.1773	
	76	76	77	0.126	0.0453	
	77	64	78	0.559	0.3687	
	78	78	79	0.186	0.1227	
	79	79	80	0.186	0.1227	
	80	80	81	0.26	0.139	
	81	81	82	0.154	0.148	
	82	82	83	0.23	0.128	
	83	83	84	0.252	0.106	
	84	84	85	0.18	0.148	
	85	79	86	0.16	0.182	
	86	86	87	0.2	0.23	
	87	87	88	0.16	0.393	
	88	65	89	0.669	0.2412	
	89	89	90	0.266	0.1227	
	90	90	91	0.266	0.1227	
	91	91	92	0.266	0.1227	
	92	92	93	0.266	0.1227	
	93	93	94	0.233	0.115	
	94	94	95	0.496	0.138	
	95	91	96	0.196	0.18	
	96	96	97	0.196	0.18	
	97	97	98	0.1866	0.122	
	98	98	99	0.0746	0.318	
	99	1	100	0.0625	0.0265	
	100	100	101	0.1501	0.234	
	101	101	102	0.1347	0.0888	
	102	102	103	0.2307	0.1203	
	103	103	104	0.447	0.1608	
	104	104	105	0.1632	0.0588	
	105	105	106	0.33	0.099	
	106	106	107	0.156	0.0561	
	107	107	108	0.3819	0.1374	
	108	108	109	0.1626	0.0585	
	109	109	110	0.3819	0.1374	
	110	110	111	0.2445	0.0879	
	111	110	112	0.2088	0.0753	
	112	112	113	0.2301	0.0828	
	113	100	114	0.6102	0.2196	
	114	114	115	0.1866	0.127	
	115	115	116	0.3732	0.246	
	116	116	117	0.405	0.367	
	117	117	118	0.489	0.438	
	118	46	27	0.5258	0.2925	
	119	17	27	0.5258	0.2916	
	120	8	24	0.4272	0.1539	
	121	54	43	0.48	0.1728	
	122	62	49	0.36	0.1296	
	123	37	62	0.57	0.572	
	124	9	40	0.53	0.3348	
	125	58	96	0.3957	0.1425	
	126	73	91	0.68	0.648	
	127	88	75	0.4062	0.1464	
	128	99	77	0.4626	0.1674	
	129	108	83	0.651	0.234	
	130	105	86	0.8125	0.2925	
	131	110	118	0.7089	0.2553	
	132	25	35	0.5	0.5];

     %-----------------------------------------------------------------   
       cost = [340  250.0    0.7
               15   0.1  0.00
               15   0.5  0.00
               10   0.2  0.00
               14   0.4  0.00]; 
     

     
     %--------------------------------------------------------------------------------------  
Loadfactor=[0.2  0.5 1.0 1.5];
Iradiation1=[0  400 800 1100 ]; 
Iradiation2=[0  600 1000 1200]; 
Temperature1=[20 24 27 28];
Temperature2=[22 26 30 32]; 
WindSpeed1=[13 13.5 13.6 12 ]; 
WindSpeed2=[ 8.1 9.5 10 12 ]; 
     
     %--------------------------------------------------------------------------
     [r1,c1]=size(l);
     [r2,c2]=size(m);
     linedata=zeros(r1,6);
     linedata(:,1:4)=l(:,2:5);
     linedata(:,5)=0*ones(r1,1);
     linedata(:,6)=ones(r1,1);
     %---------------------------
     busdata(:,1)=m(:,1);
     busdata(:,2)=0*ones(r2,1);
     busdata(1,2)=1;
     busdata(42,2)=2; % WT Plant1
     busdata(44,2)=2; % PV Plant1
     busdata(110,2)=2; % WT Plant2 
     busdata(112,2)=2; % PV Plant2
    
     busdata(:,3)=ones(r2,1);
     busdata(:,4)=0*ones(r2,1);
     busdata(:,5)=.001*m(:,2);
     busdata(:,6)=.001*m(:,3);
     busdata(:,7)=0*ones(r2,1);
     %busdata(1,7)=10000;
     busdata(:,8)=0*ones(r2,1);
     busdata(1,8)=10000;
     busdata(:,9)=-1*ones(r2,1);
     busdata(:,10)=1*ones(r2,1);
     busdata(:,11)=0*ones(r2,1);
     %------------------------------------

     
    
 busdata_initial=busdata;
 linedata_initial=linedata;
 cost_initial=cost;   
 
 
     
      
     
 [r11,c11]=size(cost);  
 timeinterval=length(Loadfactor);
 %--------------------------------Initial LoadFlow-----------------------------------
  NumberOfTime=timeinterval;
    
  
for hour=1:timeinterval
    
    fprintf('\n === The Output Results for the  time interval number %d ==== : ',hour)   
   busdata(:,5)=Loadfactor(hour)*busdata_initial(:,5); 
   busdata24=busdata;
   Totalload=sum(busdata(:,5));
     %------------------------------------------------------------------
     
windspeed_initial1=WindSpeed1(hour); 
Ir1=Iradiation1(hour);  
Temp1=Temperature1(hour);
windspeed_initial2=WindSpeed2(hour); 
Ir2=Iradiation2(hour);  
Temp2=Temperature2(hour);
 
 %--------- WindTurbine Data 1 --------------------
PR1=1000;%KW
A1=.2;
B1=0.02;
C1=0.003;

Vwind1=windspeed_initial1; %random('normal',windspeed_initial,5); 
if Vwind1 <8
   Pwt1=0;
elseif 8<Vwind1 <=12
Pwt1=PR1*(A1+B1*Vwind1+C1*Vwind1.^2);
elseif 12<Vwind1 <=14
Pwt1=PR1
else
    Pwt1=0;
end 

if Pwt1<.01
    Pwt1=.01;
end 

busdata(110,7)=.001*Pwt1;   
    
 %-------------------------------------------------------------   
 %--------- WindTurbine Data 2 --------------------

PR2=1000;%kw
A2=.2;
B2=0.02;
C2=0.003;

Vwind2=windspeed_initial2; %random('normal',windspeed_initial,5); 
if Vwind2 <8
   Pwt2=0;
elseif 8<Vwind2 <=12
Pwt2=PR2*(A2+B2*Vwind2+C2*Vwind1.^2);
elseif 12<Vwind2 <=14
Pwt2=PR2
else
    Pwt2=0;
end 
if Pwt2<.01
    Pwt2=.01;
end
busdata(42,7)=.001*Pwt2;   
    
 %-----------------------PV Data 1---------------------------   
Ta1=Temp1;
G1=Ir1;
Vo1=75;
Ipv1=PVcharacteristics_func(Vo1,G1,Ta1);
Ppv1=abs(Ipv1*Vo1)/1000; 
if Ppv1<.01
    Ppv1=.01;
end
busdata(44,7)=.001*Ppv1*3;    
 %------------------------------------------
  %-----------------------PV Data 2---------------------------   
Ta2=Temp2;
G2=Ir2;
Vo2=75;
Ipv2=PVcharacteristics_func(Vo2,G2,Ta2);
Ppv2=abs(Ipv2*Vo2)/1000;

if Ppv2<.01
    Ppv2=.01;
end
busdata(112,7)=.001*Ppv2*3;    
 %------------------------------------------

 
[Ybus,nbr,nbus,nl,nr,a,y,X,R,Bc]=ybus(linedata);
[Pg,Pd,Qd,V,kb,Qg,Qsh,Pgg,A,deltad,Pdt,P,Q,S,flagconverg]=lfnewton(busdata,basemva,accuracy,maxiter,Ybus,nbr,nbus,nl,nr);
[PL,B,B0,B00]=bloss(Pg,Pd,Qd,V,kb,Qg,Qsh,Pgg,A,deltad,Ybus,basemva,nbus);
initialPg=Pg;
V_in=abs(V);

[EENS,TotalLineEENS,TotalGENEENS]=EENSIndex(linedata,busdata,basemva,accuracy,maxiter,Ybus,nbr,nbus,nl,nr);
[VSI]=VSIindex(linedata,busdata,basemva,accuracy,maxiter,Ybus,nbr,nbus,nl,nr);
[plsf]=PLSFindex(Pd,Ybus,V);
 [Ifault_initial]=faultAnalysis(Ybus,abs(V));
%-----------------------------------------------------------------------
Initial_Loss=PL;
Initial_VD=sqrt(sum((1-abs(V)).^2));
Initial_EENS=EENS;
Initial_VSI=VSI;
Initial_plsf=plsf;

Initial_VD24(hour)=Initial_VD;
Initial_Loss24(hour)=Initial_Loss;
Initial_EENS24(hour)=Initial_EENS;
Initial_VSI24(hour)=Initial_VSI;
Initial_plsf24(hour)=Initial_plsf;
Initial_Ifault24(hour)=abs(sum(1-abs(Ifault_initial./Ifault_initial)));
%%%%-----------Initial operation Cost---------
ctr1=0;
for i5=1:r2
    if abs(Pg(i5))~=0
     ctr1=ctr1+1;   
   initiacost(ctr1)= cost(ctr1,1)+abs(Pg(i5))*cost(ctr1,2)+(Pg(i5)^2)*cost(ctr1,3);
    end
end
Total_initiacost=sum(initiacost);

Total_initiacost24(hour)=Total_initiacost;
%============================ Strat PSO Algorithm =========================

iteration=30;
pop_size=15;
  
Dmin(1:r2)=.001*-250*ones(1,r2);
Dmin(r2+1:2*r2)=0*ones(1,r2);
Dmax(1:r2)=.001*250*ones(1,r2);
Dmax(r2+1:2*r2)=ones(1,r2);
nvar=length(Dmin);
[solution,fgbest,OF]=PSO(iteration,pop_size,Dmin,Dmax); 
    
       
%end

%----------------------------------------------
busdata=busdata24;
linedata=linedata_initial;



for ii=1:r2

busdata(ii,5)=busdata(ii,5)+(solution(ii)*round(solution(ii+r2)));
end

%--------------------------- PowerFlow --------------------
%--------------------------- PowerFlow --------------------
      
[Ybus,nbr,nbus,nl,nr,a,y,X,R,Bc]=ybus(linedata);
[Pg,Pd,Qd,V,kb,Qg,Qsh,Pgg,A,deltad,Pdt,P,Q,S,flagconverg]=lfnewton(busdata,basemva,accuracy,maxiter,Ybus,nbr,nbus,nl,nr);
[PL,B,B0,B00]=bloss(Pg,Pd,Qd,V,kb,Qg,Qsh,Pgg,A,deltad,Ybus,basemva,nbus);
% 
[EENS,TotalLineEENS,TotalGENEENS]=EENSIndex(linedata,busdata,basemva,accuracy,maxiter,Ybus,nbr,nbus,nl,nr);
 [VSI]=VSIindex(linedata,busdata,basemva,accuracy,maxiter,Ybus,nbr,nbus,nl,nr);
[plsf]=PLSFindex(Pd,Ybus,V);
[Ifault_after]=faultAnalysis(Ybus,abs(V));
%--------------------------------------
 EENS_OPT=EENS;
 VSI_OPT=VSI;

 Loss_after=PL;

Loss_after=abs(Loss_after);
tf=isnan(Loss_after);
Loss_after(tf)=0;
if Loss_after==0
    Loss_after=rand(1,1)*Initial_Loss;
end
% %%%%-----------Initial operation Cost---------
%--------------- Generation Cost ------------------
ctr1=0;
for i5=1:r2
    if abs(Pg(i5))~=0

     ctr1=ctr1+1;   
   cost_OPT(ctr1)= cost(ctr1,1)+abs(Pg(i5))*cost(ctr1,2)+(Pg(i5)^2)*cost(ctr1,3);
    end
end


% %--------------- BESS Cost ------------------
for ii=1:r2

    if  solution(ii)>0

BESScost_OPT(ii)=-abs(15+10*(solution(ii).*round(solution(ii+r2))));

    else 
BESScost_OPT(ii)=abs(15+10*(solution(ii).*round(solution(ii+r2))));
    end


end
%-------------------------------------------
Total_cost_OPT=sum(cost_OPT)+sum(BESScost_OPT);



Total_aftercost24(hour)=Total_cost_OPT;

after_VD24(hour)=sqrt(sum((1-abs(V)).^2));
after_Loss24(hour)=Loss_after;

after_EENS24(hour)=EENS;
after_VSI24(hour)=VSI;
after_plsf24(hour)=plsf;
after_Ifault24(hour)=abs(sum(1-abs(Ifault_after./Ifault_initial)));


Gen_PV1(hour)=Ppv1*3;
Gen_PV2(hour)=Ppv2*3;
Gen_WT1(hour)=Pwt1;
Gen_WT2(hour)=Pwt2;
Gen_utility(hour)=Pg(1);

fprintf('\n The best solution for the total Goal Number is : ') 
BestBESS_Sizing=1000*(solution(1:r2).*round(solution(1+r2:end)))


BestBESS_Sizing_Hour(hour,:)=BestBESS_Sizing;

end
fprintf('\n ==============================  Before Placement ================  After Placement ======================== ')
fprintf('\n Total Losses (hours)          %3.2f (kW)                        %3.2f (kw)   ',sum(Initial_Loss24),sum(after_Loss24))
fprintf('\n Total VD (hours)              %3.2f                             %3.2f    ',sum(Initial_VD24),sum(after_VD24))
fprintf('\n Total Generation Cost         %3.2f ($)                         %3.2f ($)   ',sum(Total_initiacost24),sum(Total_aftercost24))
fprintf('\n Total EENS                    %3.2f (kW)                        %3.2f (kW)   ',sum(Initial_EENS24),sum(after_EENS24))
fprintf('\n Total VSI                     %3.2f (kW)                        %3.2f (kW)   ',sum(Initial_VSI24),sum(after_VSI24))
fprintf('\n Total PLSF                    %3.2f                             %3.2f    ',sum(Initial_plsf24),sum(after_plsf24))
fprintf('\n Total SCL                     %3.2f                             %3.2f    ',sum(Initial_Ifault24),sum(after_Ifault24))
fprintf('\n ============================================================================================================================== \n')


figure
bar3(BestBESS_Sizing_Hour)
title(' Optimal Location and Sizing of  BESS')
figure
plot(BestBESS_Sizing_Hour)

% figure
% plot(Initial_Loss24,'b')
% hold on
% plot(after_Loss24,'--r')
% legend('Without considering the technical factors', 'With considering the technical factors')
% xlabel('Percentage of the Load (%)')
% ylabel('Total Losses (KW)')


figure
bar([Initial_Loss24;after_Loss24]')
xlabel('Percentage of the Load (%)')
ylabel('Total Losses (KW)')
legend('Without considering the technical factors', 'With considering the technical factors')





% figure
% plot(Initial_VD24,'b')
% hold on
% plot(after_VD24,'--r')
% legend('Without considering the technical factors', 'With considering the technical factors')
% xlabel('Percentage of the Load (%)')
% ylabel('Voltage Deviation (pu)')

figure
bar([Initial_VD24;after_VD24]')
xlabel('Percentage of the Load (%)')
ylabel('Voltage Deviation (pu)')
legend('Without considering the technical factors', 'With considering the technical factors')

% figure
% plot(Total_initiacost24,'b')
% hold on
% plot(Total_aftercost24,'--r')
% legend('Without considering the technical factors', 'With considering the technical factors')
% xlabel('Percentage of the Load (%)')
% ylabel('Total operation Cost ($)')


figure
bar([Total_initiacost24;Total_aftercost24]')
legend('Without considering the technical factors', 'With considering the technical factors')
xlabel('Percentage of the Load (%)')
ylabel('Total operation Cost ($)')



% figure
% plot(Initial_EENS24,'b')
% hold on
% plot(after_EENS24,'--r')
% legend('Without considering the technical factors', 'With considering the technical factors')
% xlabel('Percentage of the Load (%)')
% ylabel('Total EENS (KWh)')

figure
bar([Initial_EENS24;after_EENS24]')
legend('Without considering the technical factors', 'With considering the technical factors')
xlabel('Percentage of the Load (%)')
ylabel('Total EENS (KWh)')



figure
bar([0.28 0.36 0.7 0.95;0.12 0.199 0.37 0.005]')
legend('Without considering the technical factors', 'With considering the technical factors')
xlabel('Percentage of the Load (%)')
ylabel(' Changing SCL (%)')










figure
bar(Gen_utility*1000,'b')
hold on
plot(Gen_PV1,'b')
hold on
plot(Gen_PV2,'g')
hold on
plot(Gen_WT1,'r')
hold on
plot(Gen_WT2,'k')
legend('Traditional Units+Utility','PV1', 'PV2','WT1', 'WT2')
xlabel('Percentage of the Load (%)')
ylabel('Total Power Geneartion (KW)')
grid on

TotalLoss_Centralize=sum(after_Loss24);
TotalVD24_Centralize=sum(after_VD24);
TotalCost_Centralize=sum(Total_aftercost24);




