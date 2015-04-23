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

mic1_raw = [X(:,mod(shift+0,14)+1),Y(:,mod(shift+0,14)+1)];
mic2_raw = [X(:,mod(shift+1,14)+1),Y(:,mod(shift+1,14)+1)];
mic3_raw = [X(:,mod(shift+2,14)+1),Y(:,mod(shift+2,14)+1)];
cjc_raw =  [X(:,mod(shift+3,14)+1),Y(:,mod(shift+3,14)+1)];
thermocouple_raw = [X(:,mod(shift+4,14)+1),Y(:,mod(shift+4,14)+1)];
gyro_x_raw =   [X(:,mod(shift+5,14)+1),Y(:,mod(shift+5,14)+1)];
gyro_y_raw =   [X(:,mod(shift+6,14)+1),Y(:,mod(shift+6,14)+1)];
gyro_z_raw =   [X(:,mod(shift+7,14)+1),Y(:,mod(shift+7,14)+1)];
accel_x_raw =  [X(:,mod(shift+8,14)+1),Y(:,mod(shift+8,14)+1)];
accel_y_raw =  [X(:,mod(shift+9,14)+1),Y(:,mod(shift+9,14)+1)];
accel_z_raw =  [X(:,mod(shift+10,14)+1),Y(:,mod(shift+10,14)+1)];
speaker1_raw = [X(:,mod(shift+11,14)+1),Y(:,mod(shift+11,14)+1)];
speaker2_raw = [X(:,mod(shift+12,14)+1),Y(:,mod(shift+12,14)+1)];
speaker3_raw = [X(:,mod(shift+13,14)+1),Y(:,mod(shift+13,14)+1)];

disp('Data has been loaded');

Sound_TandV = getTempAndVelocityFromSoundData(speaker1_raw,mic2_raw,...
                                             speaker2_raw,mic1_raw_);
thermistor = thermistor(cjc_raw);