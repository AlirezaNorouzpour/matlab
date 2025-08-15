function [EENS,TotalLineEENS,TotalGENEENS]=EENSIndex(linedata,busdata,basemva,accuracy,maxiter,Ybus,nbr,nbus,nl,nr)

EENSctr=0;
[r51,c51]=size(linedata);
[r52,c52]=size(busdata);
busdata_IN_EENS=busdata;
linedata_IN_EENS=linedata;

%%%--------Generation Outage -------------------------
GenEENS(1)=0.0;
LineEENS(1)=0.0;



for  i600=1:r52

busdata=busdata_IN_EENS;
linedata=linedata_IN_EENS;
  
    if busdata(i600,2)==2; 
     

    busdata(i600,7)=0;
    
[Ybus,nbr,nbus,nl,nr,a,y,X,R,Bc]=ybus(linedata);
[Pg,Pd,Qd,V,kb,Qg,Qsh,Pgg,A,deltad,Pdt,P,Q,S,flagconverg2]=lfnewton(busdata,basemva,accuracy,maxiter,Ybus,nbr,nbus,nl,nr);

if flagconverg2 ==1

for i601=1:r52

if  (abs (1-abs(V(i601))))>0.2

    EENSctr= EENSctr+1;
    GenEENS(EENSctr)=busdata(i601,5);

end

   
end


     
end
        
    end



end
TotalGENEENS=sum(GenEENS);

%=============================================================================
EENSctr=0;

% %%%--------Line Outages -------------------------
for  i700=1:r51


busdata=busdata_IN_EENS;
linedata=linedata_IN_EENS;

linedata(i700,3)=1e5;
linedata(i700,4)=1e5;

[Ybus,nbr,nbus,nl,nr,a,y,X,R,Bc]=ybus(linedata);
[Pg,Pd,Qd,V,kb,Qg,Qsh,Pgg,A,deltad,Pdt,P,Q,S,flagconverg2]=lfnewton(busdata,basemva,accuracy,maxiter,Ybus,nbr,nbus,nl,nr);

if flagconverg2 ==1


for i601=1:r52

if  (abs (1-abs(V(i601))))>0.2

    EENSctr= EENSctr+1;
    LineEENS(EENSctr)=busdata(i601,5);

end

   
end




end



end 
TotalLineEENS=sum(LineEENS);

 EENS=abs(TotalLineEENS+TotalGENEENS);   





