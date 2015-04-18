function data = accel_translate( input_data, channel)
%Channels: Accels 'ax' 'ay' 'az' Gyros 'gx' 'gy' 'gz' 
%   Detailed explanation goes here
if strcmp(channel,'ax')
    a = 771.094;
    b = -925.637;
elseif strcmp(channel,'ay') || strcmp(channel,'az')
    a = 12.863;
    b = -5.9127;
elseif strcmp(channel,'gx')
    a = -50.726;
    b = 33.943;
elseif strcmp(channel,'gy')
    a = -52.336;
    b = 34.778;
else
    a = -51.209;
    b = 34.034;
end
data = a + b*input_data;
end

