function data = thermistor(inputdata)
% this function converts voltages from the thermistor into temperature
% readings
%
% Inputs:
%     - inputdata: a vector of thermistor voltages
%
% Outputs:
%     - data: a vector of calculated temeratures
%

R = 100000;    % bottom of voltage divider
Rref = 100000; % ref resistance of thermistor

% resistance of the thermocouple
Rt = (R*inputdata)./(3.3-inputdata);

% steinhart-hart constants for our thermocouple
A = 3.354e-3;
B = 2.460e-4;
C = 3.405e-6;
D = 1.034e-7;

% apply the steinhart-hart function to find temerature
data = (A + B*log(Rt/Rref) + C*log(Rt/Rref).^2 + D*log(Rt/Rref).^3).^-1;

% convert to deg C
data = data-273.15;


end

