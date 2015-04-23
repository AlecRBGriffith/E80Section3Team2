function data = thermistor(inputdata)
% applies steinhart-hart function
R = 100000;             % bottom of voltage divider
Rref = 100000;          % ref resistance of thermistor
dat1 = R*inputdata;     % this makes vectorizing easier for my dumb brain
dat2 = 3.3-inputdata;
Tr = dat1./dat2;
A = 3.354e-3;
B = 2.460e-4;
C = 3.405e-6;
D = 1.034e-7;

data = (A + B*log(Tr/Rref) + C*log(Tr/Rref).^2 + D*log(Tr/Rref).^3).^-1;

data = data-273.15;


end

