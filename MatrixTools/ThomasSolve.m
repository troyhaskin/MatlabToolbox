function xSol = ThomasSolve(L,D,U,b)
    
    End			= length(D) ;
    Umod(End,1)	= 0.0       ;
    Bmod(End,1)	= 0.0       ;
    
    Umod(1) = U(1)/D(1);
    Bmod(1) = b(1)/D(1);
    
    for k = 2:End-1
        invTerm = 1 / (D(k) - Umod(k-1)*L(k))       ;
        Umod(k) = U(k) * invTerm                    ;
        Bmod(k) = (b(k) - Bmod(k-1)*L(k)) * invTerm ;
    end
    
    Bmod(End) = (b(End) - Bmod(End-1)*L(End)) / (D(End) - Umod(End-1)*L(End));
    
    xSol(End,1) = Bmod(End);
    
    for k=End-1:-1:1
        xSol(k) = Bmod(k) - Umod(k)*xSol(k+1);
    end
    
end