function data = translate_IMU_Data( input_data, channel)
%
% This function takes input voltages from the IMU and converts the to
% acceleration and angular velocity data
%
% Inputs:
%     - input_data: a vector of data from the IMU
%     - channel: a string to select which sensor produced the input data.
%               options are:
%                *Accelerometers: 'ax', 'ay', 'az' 
%                *Gyros: 'gx' 'gy' 'gz' 
% Outputs:
%     - data: the vector of data converted from the input voltages
%

% select the calibration constants using channel
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
elseif strcmp(channel,'gz')
    a = -51.209;
    b = 34.034;
else
    error(['Input to accel_translate must be one of the following: '...
        'ax,ay,az,gx,gy,gz\nInput was: %s'],channel);
end

% generate the data vector using calibration constants and the input_data
data = a + b*input_data;

end

