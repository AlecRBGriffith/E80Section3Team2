function a = accelFromFrequency( frequencyBase, frequencyShifted,c,v)
%
% Take frequences from FFT's, our currrent speed of sound and velocity,
% and get a value for acceleration
%
% Inputs:
%     - frequencyBase: a vector of the frequency of the signal applied to
%                      the speaker
%     - frequencyShifted: a vector of the frequency picked up by the mic
%     - c: vector of speed of sound values
%     - v: vector of speed of rocket values
% Outputs:
%     - a: vector of calculated acceleration
%    

    d = 0.2; % Hard code a distance here
    gain  = frequencyShifted./frequencyBase;
    a = (1-gain.^2).*(c-v).^2./(2*d);
end

