% plotRawData.m

%Close other graphs, get rid of if you want to hold
close all;
clear;

%plotting options. Maybe these should be user input controlled?
plot_temp = 1;
plot_accel = 0;
plot_gyro = 0;
plot_sound = 0;
plot_fft = 0;
plot_phase_shift = 1;

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


if (plot_temp)
    cjc =  [X(:,mod(shift+3,14)+1),Y(:,mod(shift+3,14)+1)];
    thermocouple = [X(:,mod(shift+4,14)+1),Y(:,mod(shift+4,14)+1)];
end
if (plot_gyro)
    gyro_x =   [X(:,mod(shift+5,14)+1),Y(:,mod(shift+5,14)+1)];
    gyro_y =   [X(:,mod(shift+6,14)+1),Y(:,mod(shift+6,14)+1)];
    gyro_z =   [X(:,mod(shift+7,14)+1),Y(:,mod(shift+7,14)+1)];
end
if (plot_accel)
    accel_x =  [X(:,mod(shift+8,14)+1),Y(:,mod(shift+8,14)+1)];
    accel_y =  [X(:,mod(shift+9,14)+1),Y(:,mod(shift+9,14)+1)];
    accel_z =  [X(:,mod(shift+10,14)+1),Y(:,mod(shift+10,14)+1)];
end
if (plot_phase_shift || plot_sound || plot_fft)
    speaker1 = [X(:,mod(shift+11,14)+1),Y(:,mod(shift+11,14)+1)];
    speaker2 = [X(:,mod(shift+12,14)+1),Y(:,mod(shift+12,14)+1)];
    speaker3 = [X(:,mod(shift+13,14)+1),Y(:,mod(shift+13,14)+1)];
    mic1 = [X(:,mod(shift+0,14)+1),Y(:,mod(shift+0,14)+1)];
    mic2 = [X(:,mod(shift+1,14)+1),Y(:,mod(shift+1,14)+1)];
    mic3 = [X(:,mod(shift+2,14)+1),Y(:,mod(shift+2,14)+1)];
end
disp('Data has been loaded');

%plot the data
if plot_temp
    temp = figure;
    plot(cjc(:,1),cjc(:,2),'k');
    hold on
    plot(thermocouple(:,1),thermocouple(:,2),'r');
    ylim([0 4]);
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    title('Raw Temperature Data');
    legend('Cold Junction (Thermistor)','Thermocouple');
end
    
if plot_gyro
    gyro = figure;
    subplot(2,2,1);
    plot(gyro_x(:,1),gyro_x(:,2));
    ylim([0 4]);
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    title('Raw X Axis Gyroscope Data');
    subplot(2,2,2)
    plot(gyro_y(:,1),gyro_y(:,2));
    ylim([0 4]);
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    title('Raw Y Axis Gyroscope Data');
    subplot(2,2,3)
    plot(gyro_z(:,1),gyro_z(:,2));
    ylim([0 4]);
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    title('Raw Z Axis Gyroscope Data');
end

if plot_accel
    accel = figure;
    subplot(2,2,1);
    plot(accel_x(:,1),accel_x(:,2));
    ylim([0.7 1]);
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    title('Raw X Axis Accelerometer Data');
    subplot(2,2,2)
    plot(accel_y(:,1),accel_y(:,2));
    ylim([0 4]);
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    title('Raw Y Axis Accelerometer Data');
    subplot(2,2,3)
    plot(accel_z(:,1),accel_z(:,2));
    ylim([0 4]);
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    title('Raw Z Axis Accelerometer Data');
end

if plot_sound
    sound = figure;
    subplot(2,2,1)
    
    plot(speaker1(:,1),speaker1(:,2));
    hold on
    plot(mic1(:,1),mic1(:,2),'r');
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    axis([1 1.01 0 4]);
    title('Speaker/Mic #1 Raw Data');
    legend('Speaker Data','Mic Data');
    
    subplot(2,2,2);
    plot(speaker2(:,1),speaker2(:,2),'k');
    hold on
    plot(mic2(:,1),mic2(:,2),'r');
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    axis([1 1.01 0 4]);
    title('Speaker/Mic #2 Raw Data');
    legend('Speaker Data','Mic Data');
    
    subplot(2,2,3);
    plot(speaker3(:,1),speaker3(:,2),'k');
    hold on
    plot(mic3(:,1),mic3(:,2),'r');
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    axis([1 1.01 0 4]);
    title('Speaker/Mic #3 Raw Data');
    legend('Speaker Data','Mic Data');
end

if plot_fft
    fft1 = figure;
    subplot(1,2,1)
    [f1s,X1s]=FFTrange(speaker1(1:2000,1),speaker1(1:2000,2),100,10000);
    plot(f1s,abs(X1s));
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (V)');
    title('Speaker #1 FFT');
    
    subplot(1,2,2)
    [f1m,X1m]=FFTrange(mic2(1:2000,1),mic2(1:2000,2),100,10000);
    plot(f1m,abs(X1m));
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (V)');
    title('Mic #1 FFT');
end

if plot_phase_shift
    phase = figure;
    [T,ph,~] = getPhaseDiff(speaker1,mic1,4900,5100);
    ph_filt = filter(.25, [1 -.75], ph);
    plot(T,ph);
    hold on
    plot(T,ph_filt,'r')
end

