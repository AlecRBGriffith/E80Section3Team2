function [t,temp,v] = getTempAndVelocityFromSoundData(S1,M1,S2,M2)
%
% This function takes in raw mic and speaker data and returns temperature
% data as a function of time
%
% Inputs:
%     - S1: Speaker data from the speaker outputting the ~475Hz wave
%     - M1: Mic data from the mic opposite S1
%     - S2: Speaker data from the speaker outputting the ~425Hz wave
%     - M2: Mic data from the mic opposite S2
%     NOTE: All data must be formatted with time in the first column and
%           voltage in the second (this is how we get data from the data
%           logger).
%
% Outputs:
%     - t: vector of times at which we have temperature data
%     - temp: vector of calculated temperatures at time t
%     - v: vector of calculated velocity vectors
%

%get the phase difference (and time and frequency vectors)
[t1,ph1,f1] = getPhaseDiff(S1,M1,450,500);
[t2,ph2,f2] = getPhaseDiff(S2,M2,400,450);

% get flight times for the waves
ft1 = ph1./(2*pi*f1);
ft2 = ph2./(2*pi*f2);

% HARD CODE THE DISTANCE BETWEEN THE SPEAKERS/MICS HERE (IN M)
d1 = 0.3;
d2 = 0.3;

%get the calculated speed of sound and velocity of the rocket
[c,v] = lowFreqSolver(ft1,ft2,d1,d2);

% use the midpoint between sampling times as our output time
% this should be fine if the sampling frequency is high
t = 0.5*(t1+t2);

gamma = 48.34;
R = 8.3145;
temp = c^2/(gamma*R);
