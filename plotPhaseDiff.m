%plot phase difference
function plotPhaseDiff(S,M)

samps = 1000;

ph = zeros(1, floor(length(S)/samps) );

for i = 1:samps:(length(S)-samps)
    [~,Xs] = niceFFT(S(i:i+samps,1),S(i:i+samps,2));
    [~,Xm] = niceFFT(M(i:i+samps,1),M(i:i+samps,2));
    
    [~,index] = max( abs(Xs(2:end)) );
    phase_diff = phase(Xs(index+1))-phase(Xm(index+1));
    phase_diff = mod(phase_diff,2*pi);
    ph(ceil(i/samps)) = phase_diff;
end

plot(ph);