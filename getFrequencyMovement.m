function [T,F] = getFrequencyMovement(x,t)
%
% this function takes speaker and microphone data and finds the phase
% differece as a function of time
% The frequency used is the maximum off the fft within the input frequency
% range
%
% Inputs:
%     - x: A vector which contains the sample of data which the fft will be
%     preformed on
%     - t: A vector which has the time measurment
%
% Outputs:
%     - T: time vector which is the median value of the time period the fft
%     is taken over
%     - F: a vector with the dominite frequency at each time step.


samps = 1000;

%This factor is the amount of points to the left and right that will be 
%observed when decideing the freqeuncy
%Smoothing using parobolic interpolation 
%https://mgasior.web.cern.ch/mgasior/pap/FFT_resol_note.pdf

% Initialize our Frequency vector (with 0s)
N = floor(length(x)/samps)-1;
fs = 1/(t(2) - t(1));
F = zeros(1, N);
T = zeros(1, N);


for i = 1:samps:(length(x)-samps)

    % Get the fft of our inputs 
    [freq,X] = niceFFT(t(i:i+samps), x(i:i+samps));
    % Find the maximum value and the index of that value
    [~,I] = max(X);
    
    %get the points around the max so we can use quadratic interpolation
    k1 = abs(X(I-1));
    k2 = abs(X(I));
    k3 = abs(X(I+1));
    
    interFreq = quadInterpolation(k1,k2,k3,samps,fs,I);
    
    
    F(ceil(i/samps)) = interFreq;
    T(ceil(i/samps)) = t(i + samps/2);
end


end

%Explination of code given on the following website:
%http://www.dsprelated.com/freebooks/sasp/Quadratic_Interpolation_Spectral_Peaks.html


function freq = quadInterpolation(ym1,y0,yp1,N,fs,bin)
%find the amoun the frequency is off by    
    p = (yp1 - ym1)/(2*(2*y0 - yp1 - ym1));
    
    
    freq = (((bin-1)+p) *fs)/N;
    
end