function a = accelFromFrequency( frequencyBase, frequencyShifted,c,v)
    

    d = 0.2; % Hard code a distance here
    gain  = frequencyShifted./frequencyBase;
    a = (1-gain.^2).*(c-v).^2./(2*d);
end

