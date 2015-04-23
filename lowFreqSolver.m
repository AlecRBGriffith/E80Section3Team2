function [c,v] = lowFreqSolver(t1, t2, d1, d2 )
%
% This function finds the speed of sound and the velocity of the rocket
% from the flight time of sound waves and the distances between the source
% and receiver 
%
% Inputs:
%     - t1: vector of flight times from forward speaker to back mic
%     - t2: vector of flight times from back speaker to forward mic
%     - d1: constant representing the distance between the forward speaker
%           and back mic
%     - d2: constant representing the distance between the back speaker
%           and forward mic
%
% 
% Outputs:
%     - c: vector of the calculated speed of sound at every point
%     - v: vector of the calculated velocity at every point
%

%throw an error if the input time vectors are not the same length
if length(t1) ~= length(t2)
    error(['Input flight time vectors must be the same length.\n'...
        'Length of t1: %d\nLength of t2: %d'],length(t1),length(t2));
end

% solve the equation:
% t1 = d1/(c + v)
% t2 = d2/(c - v)
c = 1/2 * (d1./t1+d2./t2);
v = 1/2 * (d1./t1-d2./t2);

end

