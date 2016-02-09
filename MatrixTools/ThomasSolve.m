function xSol = ThomasSolve(l,d,u,b)
    
    End			= length(d) ;
    Umod(End,1)	= 0.0       ;
    Bmod(End,1)	= 0.0       ;
    
    Umod(1) = u(1)/d(1);
    Bmod(1) = b(1)/d(1);
    
    for k = 2:End-1
        invTerm = 1 / (d(k) - Umod(k-1)*l(k))       ;
        Umod(k) = u(k) * invTerm                    ;
        Bmod(k) = (b(k) - Bmod(k-1)*l(k)) * invTerm ;
    end
    
    Bmod(End) = (b(End) - Bmod(End-1)*l(End)) / (d(End) - Umod(End-1)*l(End));
    
    xSol(End,1) = Bmod(End);
    
    for k=End-1:-1:1
        xSol(k) = Bmod(k) - Umod(k)*xSol(k+1);
    end
    
end