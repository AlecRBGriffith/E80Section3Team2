function [c v] = lowFreqSolver(t1, t2, d1, d2 )
    result =   [t1 t1; t2 -t2] \ [d1 ; d2];
    c = result(1);
    v = result(2);
end

