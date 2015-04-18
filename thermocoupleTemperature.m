function temp = thermocoupleTemperature( thermoV, CJC )
% Need extra function or to add in here reversing the gain and 
% voltage offset we have for this to work with the datalogger.
vOffset = 4.04504;
gain = (1+100/.560);
thermo_mV = themoV/gain - vOffset;
A = importdata('ThermoCoupleTable.txt');
mapT = -150:1:149;
temp = interp1(A,mapT,thermo_mV)+CJC;
end

