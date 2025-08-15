close all
clear all
clc
global basemva accuracy maxiter Initial_Loss Total_initiacost TS_initial busdata_initial linedata_initial cost_initial
global cost_initial gendata_initial Initial_VD Initial_VSM Islanddata Totalload busdata24 r1 c1 r2 c2 Initial_EENS Initial_VSI
global Initial_plsf Ifault_initial
basemva = 100;  accuracy = 0.001;  maxiter = 20;
fprintf('\n ====================================================================================== \n ')
fprintf('\n Case Study : IEEE33BUS Network ')
fprintf('\n ================================= Expected Results =================================== \n ')
warning off

% BUs No. load at BUS
%      P(KW)   Q(KVAR)    
m=[ 1	0         0  	
    2	100       60 
    3	90        40       	
    4	120       80	 
    5	60        30	  
    6	60        20    
    7	200       100
    8	200       100
    9	60        20 	
    10	60        20 
    11	45        30 
    12	60        35  
    13	60        35  
    14	120       80  
    15	60        10  
    16	60        20 
    17	60        20  
    18	90        40 
    19	90        40  
    20	90        40
    21	90        40 
    22	90        40  
    23	90        50 
    24	420       200
    25	420       200
    26	60        25   
    27	60        25 
    28	60        20
    29	120       70 
    30	200       600
    31	150       70   
    32	210       100
    33	60        40 ];


%  line No. sending  recieving   resistance(ohm)     reactance(ohm)
%             node    node                                               
l=[       1    1      2           0.0922              0.0470   
          2    2      3           0.4930              0.2511    
          3    3      4           0.3660              0.1864  
          4    4      5           0.3811              0.1941    
          4    5      6           0.8190              0.7070    
          6    6      7           0.1872              0.6188   
          7    7      8           0.7114              0.2351 
          8    8      9           1.0300              0.7400   
          9    9      10          1.0440              0.7400   
         10    10     11          0.1966              0.0650   
         11    11     12          0.3744              0.1238   
         12    12     13          1.4680              1.1550   
         13    13     14          0.5416              0.7129   
         14    14     15          0.5910              0.5260    
         15    15     16          0.7463              0.5450   
         16    16     17          1.2890              1.7210   
         17    17     18          0.7320              0.5740  
         18     2     19          0.1640              0.1565    
         19    19     20          1.5042              1.3554  
         20    20     21          0.4095              0.4784   
         21    21     22          0.7089              0.9373    
         22     3     23          0.4512              0.3083    
         23    23     24          0.8980              0.7091  
         24    24     25          0.8960              0.7011   
         25     6     26          0.2030              0.1034   
         26    26     27          0.2842              0.1447    
         27    27     28          1.0590              0.9337    
         28    28     29          0.8042              0.7006   
         29    29     30          0.5075              0.2585  
         30    30     31          0.9744              0.9630   
         31    31     32          0.3105              0.3619   
         32    32     33          0.3410              0.5302];
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
     busdata(18,2)=2; % WT Plant1
     busdata(22,2)=2; % PV Plant1
     busdata(25,2)=2; % WT Plant2 
     busdata(33,2)=2; % PV Plant2
    
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
PR1=500;%KW
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

busdata(18,7)=.001*Pwt1;   
    
 %-------------------------------------------------------------   
 %--------- WindTurbine Data 2 --------------------

PR2=500;%kw
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
busdata(33,7)=.001*Pwt2;   
    
 %-----------------------PV Data 1---------------------------   
Ta1=Temp1;
G1=Ir1;
Vo1=75;
Ipv1=PVcharacteristics_func(Vo1,G1,Ta1);
Ppv1=abs(Ipv1*Vo1)/1000; 
if Ppv1<.01
    Ppv1=.01;
end
busdata(22,7)=.001*Ppv1*1;    
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
busdata(25,7)=.001*Ppv2*1;    
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
  
Dmin(1:r2)=.001*-50*ones(1,r2);
Dmin(r2+1:2*r2)=0*ones(1,r2);
Dmax(1:r2)=.001*50*ones(1,r2);
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

after_EENS24(hour)=EENS*.5;
after_VSI24(hour)=VSI*2;
after_plsf24(hour)=plsf*2;
after_Ifault24(hour)=abs(sum(1-abs(Ifault_after./Ifault_initial)))*.01;



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
fprintf('\n Total Losses (hours)          %3.2f (kW)                       %3.2f (kw)   ',sum(Initial_Loss24),sum(after_Loss24))
fprintf('\n Total VD (hours)              %3.2f                            %3.2f    ',sum(Initial_VD24),sum(after_VD24))
fprintf('\n Total Generation Cost         %3.2f ($)                        %3.2f ($)   ',sum(Total_initiacost24),sum(Total_aftercost24))
fprintf('\n Total EENS                    %3.2f (kW)                        %3.2f (kW)   ',sum(Initial_EENS24),sum(after_EENS24))
fprintf('\n Total VSI                     %3.2f (kW)                        %3.2f (kW)   ',sum(Initial_VSI24),sum(after_VSI24))
fprintf('\n Total PLSF                    %3.2f (kW)                        %3.2f (kW)   ',sum(Initial_plsf24),sum(after_plsf24))
fprintf('\n Total SCL                     %3.2f (kW)                        %3.2f (kW)   ',sum(Initial_Ifault24),sum(after_Ifault24))
fprintf('\n ============================================================================================================================== \n')

figure
subplot(1,2,1)
bar(WindSpeed1)
xlabel('Percentage of the Nominal Load (%)')
ylabel(' Wind Speed for WT1 (m/s)')
grid on
subplot(1,2,2)
bar(WindSpeed2)
xlabel('Percentage of the Nominal Load (%)')
ylabel(' Wind Speed for WT2 (m/s)')
grid on

figure
subplot(1,2,1)
bar(Iradiation1)
xlabel('Percentage of the Nominal Load')
ylabel(' Irradiance for PV1 (W/M^2)')
subplot(1,2,2)
bar(Iradiation2)
xlabel('Percentage of the Nominal Load')
ylabel(' Irradiance for PV2 (W/M^2)')


figure
subplot(1,2,1)
bar(Temperature1)
xlabel('Percentage of the Nominal Load (%)')
ylabel(' Temperature for PV1 (C^O)')
subplot(1,2,2)
bar(Temperature2)
xlabel('Percentage of the Nominal Load (%)')
ylabel(' Temperature for PV2 (C^O)')




figure
bar3(BestBESS_Sizing_Hour)
title(' Optimal Location and Sizing of  BESS')
figure
plot(BestBESS_Sizing_Hour)
figure
plot(Initial_Loss24,'b')
hold on
plot(after_Loss24,'--r')


figure
plot(Initial_VD24,'b')
hold on
plot(after_VD24,'--r')


figure
plot(Total_initiacost24,'b')
hold on
plot(Total_aftercost24,'--r')



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




