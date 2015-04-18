function temp = thermocoupleTemperature( thermoV, CJC )
vOffset = 4.04504;
gain = (1+100/.560);
thermo_mV = themoV/gain - vOffset;
A = importdata('ThermoCoupleTable.txt');
mapT = -150:1:149;
temp = interp1(A,mapT,thermo_mV)+CJC;
end

