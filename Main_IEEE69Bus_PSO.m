    clear all
    clc
    global basemva accuracy maxiter Initial_Loss Total_initiacost TS_initial busdata_initial linedata_initial cost_initial
    global cost_initial gendata_initial Initial_VD Initial_VSM Islanddata Totalload busdata24 r1 c1 r2 c2 Initial_EENS Initial_VSI
    global Initial_plsf Ifault_initial
    basemva = 100;  accuracy = 0.001;  maxiter = 20;
    fprintf('\n ==off==================================================================================== \n ')
    fprintf('\n Case Study : IEEE69BUS Network ')
    fprintf('\n ================================= Expected Results =================================== \n ')
    warning off
    
    
      % BUs No. load at BUS
    %      P(KW)   Q(KVAR)    
    m=[1	0	0
    2	0	0
    3	0	0
    4	0	0
    5	2.60000000000000	2.20000000000000
    6	40.4000000000000	30
    7	75	54
    8	30	22
    9	28	19
    10	145	104
    11	145	104
    12	288	291.110000000000
    13	8	5.50000000000000
    14	0	0
    15	45.5000000000000	30
    16	60	35
    17	60	35
    18	0	0
    19	1	0.600000000000000
    20	114	81
    21	5.30000000000000	3.50000000000000
    22	280	285.610000000000
    23	28	20
    24	0	0
    25	14	10
    26	14	10
    27	26	18.6000000000000
    28	26	18.6000000000000
    29	0	0
    30	0	0
    31	0	0
    32	294	295.650000000000
    33	19.5000000000000	14
    34	6	4
    35	26	18.5500000000000
    36	26	18.5500000000000
    37	0	0
    38	24	17
    39	24	17
    40	1.20000000000000	1
    41	0	0
    42	6	4.30000000000000
    43	0	0
    44	39.2200000000000	26.3000000000000
    45	39.2200000000000	26.3000000000000
    46	0	0
    47	79	56.4000000000000
    48	384.700000000000	274.500000000000
    49	384.700000000000	274.500000000000
    50	40.5000000000000	28.3000000000000
    51	3.60000000000000	2.70000000000000
    52	4.35000000000000	3.50000000000000
    53	26.4000000000000	19
    54	24	17.2000000000000
    55	0	0
    56	0	0
    57	0	0
    58	100	72
    59	0	0
    60	1244	888
    61	32	23
    62	0	0
    63	227	162
    64	59	42
    65	18	13
    66	18	13
    67	28	20
    68	28	20
    69	10	15];
    
      
    %  line No. sending  recieving   resistance(ohm)     reactance(ohm)
    %             node    node                                               
      
    l=[1	1	2	0.0005	0.0012
       2	2	3	0.0005	0.0012
       3	3	4	0.0015	0.0036
       4	4	5	0.0251000000000000	0.0294000000000000
       5	5	6	0.366000000000000	0.186400000000000
       6	6	7	0.381100000000000	0.194100000000000
       7	7	8	0.0922000000000000	0.0470000000000000
       8	8	9	0.0493000000000000	0.0251000000000000
       9	9	10	0.819000000000000	0.270700000000000
       10	10	11	0.187200000000000	0.0619000000000000
       11	11	12	0.711400000000000	0.235100000000000
       12	12	13	1.03000000000000	0.340000000000000
       13	13	14	1.04400000000000	0.345000000000000
       14	14	15	1.05800000000000	0.349600000000000
       15	15	16	0.196600000000000	0.0650000000000000
       16	16	17	0.374400000000000	0.123800000000000
       17	17	18	0.00470000000000000	0.00160000000000000
       18	18	19	0.327600000000000	0.108300000000000
       19	19	20	0.210600000000000	0.0696000000000000
       20	20	21	0.341600000000000	0.112900000000000
       21	21	22	0.0140000000000000	0.00460000000000000
       22	22	23	0.159100000000000	0.0526000000000000
       23	23	24	0.346300000000000	0.114500000000000
       24	24	25	0.748800000000000	0.247500000000000
       25	25	26	0.308900000000000	0.102100000000000
       26	26	27	0.173200000000000	0.0572000000000000
       27	3	28	0.00440000000000000	0.0108000000000000
       28	28	29	0.0640000000000000	0.156500000000000
       29	29	30	0.397800000000000	0.131500000000000
       30	30	31	0.0702000000000000	0.0232000000000000
       31	31	32	0.351000000000000	0.116000000000000
       32	32	33	0.839000000000000	0.281600000000000
       33	33	34	1.70800000000000	0.564600000000000
       34	34	35	1.47400000000000	0.487300000000000
       35	3	36	0.00440000000000000	0.0108000000000000
       36	36	37	0.0640000000000000	0.156500000000000
       37	37	38	0.105300000000000	0.123000000000000
       38	38	39	0.0304000000000000	0.0355000000000000
       39	30	40	0.00180000000000000	0.00210000000000000
       40	40	41	0.728300000000000	0.850900000000000
       41	41	42	0.310000000000000	0.362300000000000
       42	42	43	0.0410000000000000	0.0478000000000000
       43	43	44	0.00920000000000000	0.0116000000000000
       44	44	45	0.108900000000000	0.137300000000000
       45	45	46	0.000900000000000000	0.00120000000000000
       46	4	47	0.00340000000000000	0.00840000000000000
       47	47	48	0.0851000000000000	0.208300000000000
       48	48	49	0.289800000000000	0.709100000000000
       49	49	50	0.0822000000000000	0.201100000000000
       50	8	51	0.0928000000000000	0.477300000000000
       51	51	52	0.331900000000000	0.111400000000000
       52	9	53	0.174000000000000	0.0886000000000000
       53	53	54	0.203000000000000	0.103400000000000
       54	54	55	0.284200000000000	0.144700000000000
       55	55	56	0.281300000000000	0.143300000000000
       56	56	57	1.59000000000000	0.533700000000000
       57	57	58	0.783700000000000	0.263000000000000
       58	58	59	0.304200000000000	0.100600000000000
       59	59	60	0.386100000000000	0.117200000000000
       60	60	61	0.507500000000000	0.258500000000000
       61	61	62	0.0974000000000000	0.0496000000000000
       62	62	63	0.0145000000000000	0.0738000000000000
       63	63	64	0.710500000000000	0.361900000000000
       64	64	65	1.04100000000000	0.530200000000000
       65	11	66	0.201200000000000	0.0611000000000000
       66	66	67	0.00470000000000000	0.00140000000000000
       67	12	68	0.739400000000000	0.244400000000000
       68	68	69	0.00470000000000000	0.00160000000000000];
    %------------------------------------------------
        
    
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
         busdata(44,2)=2; % WT Plant1
         busdata(48,2)=2; % PV Plant1
         busdata(40,2)=2; % WT Plant2 
         busdata(42,2)=2; % PV Plant2
        
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
    
    busdata(44,7)=.001*Pwt1;   
        
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
    busdata(40,7)=.001*Pwt2;   
        
     %-----------------------PV Data 1---------------------------   
    Ta1=Temp1;
    G1=Ir1;
    Vo1=75;
    Ipv1=PVcharacteristics_func(Vo1,G1,Ta1);
    Ppv1=abs(Ipv1*Vo1)/1000; 
    if Ppv1<.01
        Ppv1=.01;
    end
    busdata(48,7)=.001*Ppv1*3;    
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
    busdata(42,7)=.001*Ppv2*3;    
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
    fprintf('\n Total Losses (hours)          %3.2f (MW)                       %3.2f (Mw)   ',sum(Initial_Loss24),sum(after_Loss24))
    fprintf('\n Total VD (hours)              %3.2f                            %3.2f    ',sum(Initial_VD24),sum(after_VD24))
    fprintf('\n Total Generation Cost         %3.2f ($)                        %3.2f ($)   ',sum(Total_initiacost24),sum(Total_aftercost24))
    fprintf('\n Total EENS                    %3.2f (MW)                        %3.2f (MW)   ',sum(Initial_EENS24),sum(after_EENS24))
    fprintf('\n Total VSI                     %3.2f (MW)                        %3.2f (MW)   ',sum(Initial_VSI24),sum(after_VSI24))
    fprintf('\n Total PLSF                    %3.2f (MW)                        %3.2f (MW)   ',sum(Initial_plsf24),sum(after_plsf24))
    fprintf('\n Total SCL                     %3.2f (MW)                        %3.2f (MW)   ',sum(Initial_Ifault24),sum(after_Ifault24))
    fprintf('\n ============================================================================================================================== \n')
    
    figure
    subplot(1,2,1)
    bar(WindSpeed1)
    xlabel('Percentage of the Nominal Load')
    ylabel(' Wind Speed for WT1 (m/s)')
    subplot(1,2,2)
    bar(WindSpeed2)
    xlabel('Percentage of the Nominal Load')
    ylabel(' Wind Speed for WT2 (m/s)')
    
    
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
    xlabel('Percentage of the Nominal Load')
    ylabel(' Temperature for PV1 (C^O)')
    subplot(1,2,2)
    bar(Temperature2)
    xlabel('Percentage of the Nominal Load')
    ylabel(' Temperature for PV2 (C^O)')
    
    figure
    plot(Temperature1)
    xlabel('Percentage of the Nominal Load')
    ylabel(' Temperature for PV1 (C^O)')
    
    
    
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
    
    
    
    

