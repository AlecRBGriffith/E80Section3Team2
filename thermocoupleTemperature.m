function temp = thermocoupleTemperature( thermo_mV, CJC )
% Need extra function or to add in here reversing the gain and 
% voltage offset we have for this to work with the datalogger.
A = importdata('ThermoCoupleTable.txt');
mapT = -150:1:149;
temp = interp1(A,mapT,thermo_mV)+CJC;
end

