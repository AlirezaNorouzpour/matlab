function [Ifault]=faultAnalysis(ybus,Voltage_Mag)

[r1,c2]=size(ybus);

for i=1:r1
    
Ifault(i)=abs(Voltage_Mag(i)/inv(ybus(i,i)));
end