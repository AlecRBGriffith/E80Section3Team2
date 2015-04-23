function a = accelFromFrequency( frequencyBase, frequencyShifted,c,v)
%
% Take frequences from FFT's, our currrent speed of sound and velocity,
% and get a value for acceleration
% Inputs:
%     - frequencyBase: frequency base, speaker frequency
%     - frequencyShifted: frequency from FFT of mic
%     - c: speed of sound at this instant
%     - v: speed of rocket at this instant
% Outputs:
%     - a: acceleration
%    

    d = 0.2; % Hard code a distance here
    gain  = frequencyShifted./frequencyBase;
    a = (1-gain.^2).*(c-v).^2./(2*d);
end

