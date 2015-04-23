%plotData.m

% plotRawData.m

%Close other graphs, get rid of if you want to hold
close all;
clear;

%plotting options. Maybe these should be user input controlled?
plot_temp = 1;
plot_accel = 1;
plot_gyro = 1;
plot_sound = 1;
plot_fft = 1;
plot_phase_shift = 0;

disp(sprintf(['\nThis script will take the data off of the SD card and '...
    'plot the data nicely.\nWarning: This will take a very long time'...
    ' with a large data file.\n']));

% Get the input filename:
SDOption = '';
while (~strcmp(SDOption,'y') && ~strcmp(SDOption,'n'))
    SDOption = input(['Do you want to take the data from the SD card?'...
        ' [y/n] '],'s');
    if(strcmp(SDOption,'y'))
        file_number = input(['Enter the last two digits of the file number'...
        ' (files are in form "DATA00XX.DAT"): '],'s');
        filename = ['/Volumes/E80S3T2/DATA00' file_number '.DAT'];
        continue;
    end
    if(strcmp(SDOption,'n'))
        filename = input('Enter filename: ','s');
        continue;
    end
    disp('Enter y or n\n');
end
disp(sprintf('\n'));

channels = 14;

%Load the input file using the provided function
[X,Y] = ReadBinaryFileTX(filename,channels,300000,3.3);
%Shift variable for misallinged data

%unpackage the arrays into usable data
shift = 0;

mic1_raw = [X(:,1),Y(:,1)];
mic2_raw = [X(:,2),Y(:,2)];
mic3_raw = [X(:,3),Y(:,3)];
cjc_raw =  [X(:,4),Y(:,4)];
thermocouple_raw = [X(:,5),Y(:,5)];
gyro_x_raw =   [X(:,6),Y(:,6)];
gyro_y_raw =   [X(:,7),Y(:,7)];
gyro_z_raw =   [X(:,8),Y(:,8)];
accel_x_raw =  [X(:,9),Y(:,9)];
accel_y_raw =  [X(:,10),Y(:,10)];
accel_z_raw =  [X(:,11),Y(:,11)];
speaker1_raw = [X(:,12),Y(:,12)];
speaker2_raw = [X(:,13),Y(:,13)];
speaker3_raw = [X(:,14),Y(:,14)];

disp('Data has been loaded');

[sound_tv_time,sound_temp,sound_v] = getTempAndVelocityFromSoundData(...
                             speaker1_raw,mic2_raw,speaker2_raw,mic1_raw_);
                         
cjc_time = cjc_raw(:,1);
cjc_temp = thermistor(cjc_raw(:,2));

thermocouple_time = thermocouple_raw(:,1);
thermocouple_temp = thermocoupleTemperature(thermocouple_raw(:,2),cjc_temp);

gx = translate_IMU_Data(gyro_x_raw(:,2))
