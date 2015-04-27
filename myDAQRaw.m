%myDAQRaw.m

filename = input('File name: ');

clear all
clear

plot_temp = 0;
plot_accel = 1;
plot_gyro = 0;
plot_sound = 1;
plot_fft = 1;
plot_phase_shift = 1;

rawdat = importdata(filename);

tt = rawdat.data(1);

speaker1 = rawdat.data(2);
speaker2 = rawdat.data(3);
mic1 = rawdat.data(4);
mic2 = rawdat.data(5);
accelx = rawdat.data(6);




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
%     subplot(2,2,1);
    plot(accel_x(:,1),accel_x(:,2));
    ylim([0.7 1]);
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    title('Raw X Axis Accelerometer Data');
%     subplot(2,2,2)
%     plot(accel_y(:,1),accel_y(:,2));
%     ylim([0 4]);
%     xlabel('Time (s)');
%     ylabel('Voltage (V)');
%     title('Raw Y Axis Accelerometer Data');
%     subplot(2,2,3)
%     plot(accel_z(:,1),accel_z(:,2));
%     ylim([0 4]);
%     xlabel('Time (s)');
%     ylabel('Voltage (V)');
%     title('Raw Z Axis Accelerometer Data');
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
    
%     subplot(2,2,3);
%     plot(speaker3(:,1),speaker3(:,2),'k');
%     hold on
%     plot(mic3(:,1),mic3(:,2),'r');
%     xlabel('Time (s)');
%     ylabel('Voltage (V)');
%     axis([1 1.01 0 4]);
%     title('Speaker/Mic #3 Raw Data');
%     legend('Speaker Data','Mic Data');
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
    [f1m,X1m]=FFTrange(mic1(1:2000,1),mic1(1:2000,2),100,10000);
    plot(f1m,abs(X1m));
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (V)');
    title('Mic #1 FFT');
end

if plot_phase_shift
    phase = figure;
    [X,ph] = getPhaseDiff(speaker1,mic1,400,550);
    ph_filt = filter(.5, [1 -.5], ph);
    plot(X,ph);
    hold on
    plot(X,ph_filt,'r')
end

