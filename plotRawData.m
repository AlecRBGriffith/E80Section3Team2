% plotRawData.m

clear;

%plotting options. Maybe these should be user input controlled?
plot_temp = 0;
plot_accel = 0;
plot_gyro = 0;
plot_sound = 0;
plot_fft = 0;
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

%Load the input file using the provided function
[X,Y] = ReadBinaryFileTX(filename,14,300000,3.3);

%unpackage the arrays into usable data
mic1 = [X(:,1),Y(:,1)];
mic2 = [X(:,2),Y(:,2)];
mic3 = [X(:,3),Y(:,3)];
cjc = [X(:,4),Y(:,4)];
thermocouple = [X(:,5),Y(:,5)];
gyro_x = [X(:,6),Y(:,6)];
gyro_y = [X(:,7),Y(:,7)];
gyro_z = [X(:,8),Y(:,8)];
accel_x = [X(:,9),Y(:,9)];
accel_y = [X(:,10),Y(:,10)];
accel_z = [X(:,11),Y(:,11)];
speaker1 = [X(:,12),Y(:,12)];
speaker2 = [X(:,13),Y(:,13)];
speaker3 = [X(:,14),Y(:,14)];

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
    [f1s,X1s]=niceFFT(speaker1(1:2000,1),speaker1(1:2000,2));
    plot(f1s,abs(X1s));
    xlim([100,10000]);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (V)');
    title('Speaker #1 FFT');
    
    subplot(1,2,2)
    [f1m,X1m]=niceFFT(mic1(1:2000,1),mic1(1:2000,2));
    plot(f1m,abs(X1m));
    xlim([100,10000]);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (V)');
    title('Mic #1 FFT');
end

if plot_phase_shift
    phase = figure;
    [t,ph] = getPhaseDiff(speaker1,mic1,400,550);
    ph_filt = filter(.25, [1 -.75], ph);
    plot(t,ph);
    hold on
    plot(t,ph_filt,'r')
end

