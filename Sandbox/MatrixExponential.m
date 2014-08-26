function ExpA = MatrixExponential(A)
    
    nRows     = size(A,1)   ;
    ExpA      = speye(nRows);
    Error     = ExpA * 0    ;
    kthTerm   = ExpA        ;
    Tolerance = 1E-12       ; 
    k         = 1           ;
    t         = 0.01        ;
    
    while normest(kthTerm) > Tolerance
        kthTerm = kthTerm * A * t / k;
        [ExpA,Error] = KahanSum(ExpA,kthTerm,Error);
        k       = k + 1;
    end
    
    for k = 1:100
        ExpA = ExpA * ExpA;
    end
    
end