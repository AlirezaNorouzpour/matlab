function [plsf]=PLSFindex(Pd,Ybus,V)
[rbus,cbus]=size(Ybus);


for ibus=1:rbus

plsf_bus(ibus)=real(inv(Ybus(ibus,ibus)))*2*Pd(ibus)/(abs(V(ibus)).^2);
end

plsf=sum(plsf_bus);


