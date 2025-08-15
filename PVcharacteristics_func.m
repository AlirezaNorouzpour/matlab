function Ipv=PVcharacteristics_func(Va,G,Tcell)
%PV_characteristics_func
%This function uses the output voltage, irradiance and ambient temperature
%to calculate the current of the PV array

k = 1.38e-23; % Boltzmann’s const
q = 1.60e-19; % Electron charge
% Photovoltaic constants at STC
A = 2; % "diode quality" factor (from PV-DesignPro-S)
Egap = 2.12; % band gap voltage for silicon devices
Num_Series = 75; % series connected cells
Voc = 43.2; % open circuit voltage at STC
Isc = 8.71; % short circuit current at STC
TempCoefI = 0.05; %current temperature cvoefficient
TempCoefV = -0.34; %voltage temperature coefficient
deltaVdeltaI_Voc = -0.45; % values at Voc from manufacturers curves
% Initial temperature T1 variables at STC
T1 = 273 + 25; % convert ambient temperature to Kelvin
Voc_T1 = Voc ./Num_Series; % open cct voltage per cell at T1
Isc_T1 = Isc; % short cct current per cell at T1
T2 = 273 + 75; % convert temperature to Kelvin 
Voc_T2 = Voc + (50.*TempCoefV)./Num_Series; % Voc per cell at T2
Isc_T2 = Isc + (50.*TempCoefI); % Isc per cell at T2
TaK = 273 + Tcell; % module temperature in Kelvin at any temperature
Vc = Va./Num_Series; % determine the cell voltage
Iph_T1 = Isc_T1 * (G./1000);%current produced by the cell at temp 1
a = (Isc_T2 - Isc_T1)/Isc_T1 * 1/(T2 - T1);%a=constant
Iph = Iph_T1 * (1 + a*(TaK - T1));%current produced by cell
Vt_T1 = k * T1 / q; %Define thermal properties(Vt) at Temp1
Ir_T1 = Isc_T1 / (exp (Voc_T1/ (A*Vt_T1))-1);%diode reverse saturation curent
b = Egap * q /(A * k);
Ir = Ir_T1 * (TaK/T1)^(3/A) .* exp(-b *(1/TaK - 1/T1));%reverse saturation current at T1
Xv = Ir_T1/(A*Vt_T1) * exp(Voc_T1/(A*Vt_T1));%cell series impedance
deltaVdeltaI_Voc_per_cell = (deltaVdeltaI_Voc)/Num_Series;
Rs = - deltaVdeltaI_Voc_per_cell - 1/Xv;
%define thermal properties at temperature TaK
Vt_TaK = A * k * TaK / q;
Ipv = zeros(size(Vc));
for j=1:5; %calculates Ia using Newton's method
Ipv = Ipv - (Iph - Ipv - Ir.*( exp((Vc+Ipv.*Rs)./Vt_TaK) -1))...
./ (-1 - (Ir.*( exp((Vc+Ipv.*Rs)./Vt_TaK) -1)).*Rs./Vt_TaK);
if G<10
    Ipv=0;
end
end
end