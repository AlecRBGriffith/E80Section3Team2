%testFFT.m

t = linspace(0,9.9,100);
x = sin(2*pi*t);

[f,mag,ph] = niceFFT(t,x);
plot(f,mag);