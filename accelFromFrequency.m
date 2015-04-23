function a = accelFromFrequency( frequencyBase, frequencyShifted,c,v)
    % Pass in the frequency base(found from the looking at the sound
    % output)
    % The measured frequency from the mic at the other terminal, frequency
    % shifted
    % Also pass c and v found using the other calculation with the low
    % frequency waves
    % Overall this will translate all of this into a measured acceleration
    d = 0.2; % Hard code a distance here
    gain  = frequencyShifted./frequencyBase;
    a = (1-gain.^2).*(c-v).^2./(2*d);
end

