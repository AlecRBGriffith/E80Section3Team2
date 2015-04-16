%testFFT.m

t = linspace(0,9.9,100);
x = sin(2*pi*t);

[f,X] = FFTrange(t,x,0.5,1.5);
plot(f,abs(X));