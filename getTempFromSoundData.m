function [t,temp] = getTempFromSoundData(S1,M1,S2,M2)
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
%


[t1,ph1] = getPhaseDiff(S1,M1,450,500);
[t2,ph2] = getPhaseDiff(S2,M2,400,450);

