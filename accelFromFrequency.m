function acceleration = accelFromFrequency( frequencyBase, frequnecyShifted,c,v)
    d = 0.2; % Hard code a distance here
    gain  = frequencyShifted./frequencyBase;
    a = (1-g.^2).*(c-v).^2./(2*d);
end

