function [f,X] = niceFFT(t,x)
%
% This function takes the fft of the input data and outputs frequency and 
% phasor vectors
%
% Inputs:
%     - t: the time vector
%     - x: the data vector, x(t) that we want to represent in the frequency
%          domain
%     NOTE: t and x must be the same length
%
% Outputs:
%     - f: a vector of frequencies
%     - X: the phasor vector, which is the fft of x(t) at frequency f
%


X = fft(x)/length(x);
%get the first half of X (positive frequencies)
X = X(1:floor(length(X)/2));

fs = 1/(t(2)-t(1));
f0 = fs/(2*length(X));
f = 0:f0:f0*(length(X)-1);

end
