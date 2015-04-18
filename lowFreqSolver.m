function [c v] = lowFreqSolver(t1, t2, d1, d2 )
    for i = 1:length(t1)
        result =   [t1(i) t1(i); t2(i) -t2(i)] \ [d1(i) ; d2(i)];
        c(i) = result(1);
        v(i) = result(2);
    end 
end

