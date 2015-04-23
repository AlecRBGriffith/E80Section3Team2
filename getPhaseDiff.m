function [t,ph,f] = getPhaseDiff(S,M,fmin,fmax)
%
% this function takes speaker and microphone data and finds the phase
% differece as a function of time
% The frequency used is the maximum of the fft within the input frequency
% range
%
% Inputs:
%     - S: A vector of the speaker data. This vector must have the data in
%          two columns, with time in the first column and voltage in the 
%          second
%     - M: A vector of the microphone data. This vector should be formatted
%          in the same way as the speaker data vector
%     - fmin: The minimum frequency that is used to search for the dominant
%             input frequency
%     - fmax: The maximum frequency that is used to search for the dominant
%             input frequency
%
% Outputs:
%     - t: A time vector, with the points in time that the phase difference
%          was calculated. This time corresponds to the middle of a time
%          interval on which we calculated phase difference.
%     - ph: The phase difference vector, with the difference in phase at 
%           the desired frequency, in radians, as a function of time
%

% This is the sample width for taking ffts. 1000 works well for frequencies
% around 500Hz
samps = 1000;

% Initialize our phase vector (with 0s)
N = floor(length(S)/samps);
ph = zeros(1, N);
f  = zeros(1, N);

% Generate the time vector
dt = (S(2,1)-S(1,1))*samps;
t = 0:dt:dt*(N-1);

% get the time between samples of the speaker and samples of the mic
% this is used to calculate the phase offset due to not sampling
% simulatneously
time_diff = S(1,1)-M(1,1);

for i = 1:samps:(length(S)-samps)
    % Get the fft of our inputs inside the frequency range and over a short
    % period of time (number of points = samps)
    [fs,Xs] = FFTrange(S(i:i+samps,1),S(i:i+samps,2),fmin,fmax);
    [~,Xm] = FFTrange(M(i:i+samps,1),M(i:i+samps,2),fmin,fmax);

    % Get the index of the dominant frequency from the speaker in the
    % frequency range
    [~,index] = max( abs(Xs(2:end)) );
    
    % Get the phase offset due to not sampling simultaneously
    phase_offset = 2*pi*fs(index)*time_diff;
    
    % Get the phase difference between the speaker and mic, and store it in
    % the phase vector, ph
    phase_diff = phase(Xs(index+1))-phase(Xm(index+1));
    phase_diff = mod(phase_diff,2*pi);
    ph(ceil(i/samps)) = phase_diff+phase_offset;
    f(ceil(i/samps)) = fs;
end

end
