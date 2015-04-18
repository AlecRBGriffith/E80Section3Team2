function temperature = tempFromSound(time)
    distance = 0.6;
    velocity = distance/time;
    temperature = 273.15*((velocity/331.3)^2-1);
end

