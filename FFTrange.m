function [f,X] = FFTrange(t,x,fmin,fmax)
%
% This function takes the fft of the input data and outputs frequency and 
% phasor vectors inside a given frequency range
%
% Inputs:
%     - t: the time vector
%     - x: the data vector, x(t) that we want to represent in the frequency
%          domain
%     - fmin: minimum frequency of the fft to be returned
%     - fmax: maximum frequency of the fft to be returned
%     NOTE: t and x must be the same length
%
% Outputs:
%     - f: a vector of frequencies between fmin and fmax
%     - X: the phasor vector, which is the fft of x(t) at frequency f
%


X = fft(x)/length(x);
%get the first half of X (positive frequencies)
X = X(1:floor(length(X)/2));

fs = 1/(t(2)-t(1));
f0 = fs/(2*length(X));
f = 0:f0:f0*(length(X)-1);

imin = floor(fmin/f0);
imax = ceil(fmax/f0);

X = X(imin:imax);
f = f(imin:imax);