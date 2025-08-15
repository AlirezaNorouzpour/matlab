function [lal]=VSIindex(linedata,busdata,basemva,accuracy,maxiter,Ybus,nbr,nbus,nl,nr)

loadctr=0;
Loadstep=1;
ColapceFlag=inf;
VFlag=inf;
flagconverg=0;

%        Bus Bus  Voltage Angle   ---Load---- -------Generator----- Injected
%        No  code Mag.    Degree  MW    Mvar  MW  Mvar Qmin Qmax     Mvar
busdata_in_VSI=busdata;


[r_VSI,c_VSI]=size(busdata_in_VSI);

while   flagconverg==0   & VFlag>0.4

  loadctr= loadctr+1;
  Loadstep=Loadstep+0.1; 

busdata=busdata_in_VSI;



busdata(:,5)= busdata_in_VSI(:,5)*(Loadstep);
totalload(loadctr)=sum(busdata(:,5));

 
[Ybus,nbr,nbus,nl,nr,a,y,X,R,Bc]=ybus(linedata);
[Pg,Pd,Qd,V,kb,Qg,Qsh,Pgg,A,deltad,Pdt,P,Q,S,flagconverg]=lfnewton(busdata,basemva,accuracy,maxiter,Ybus,nbr,nbus,nl,nr);


ColapceFlag=min(abs(eig(A)));
 Vcap(loadctr)=min(abs(V));
 VFlag=min(abs(V));

end

% 
% figure
% plot(totalload,Vcap)
lal=totalload(end);


