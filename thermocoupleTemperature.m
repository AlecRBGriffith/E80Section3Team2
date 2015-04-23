function temp = thermocoupleTemperature( thermoV, CJC )
% First we have the voltage offset we initial add
% to the thermocouple voltage to insure it is always positive
vOffset = 4.04504;
% This is the gain factor for the instrumentation amp
gain = (1+100/.560);
% We can calculate the actual voltage difference from the thermocouple
% Effectively this is just undoing our signal conditioning
% Check the vOffset multiplier
thermo_mV = 1000*thermoV/gain - vOffset*2;
% Load the lookup table of thermocouple voltages
A = importdata('ThermoCoupleTable.txt');
% The temperatures which correspond with the lookup table voltages
mapT = -150:1:149;
% Now just interpolate
temp = interp1(A,mapT,thermo_mV)+CJC;
end

