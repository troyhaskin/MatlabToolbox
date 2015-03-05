function Roots = LegendreRoots(n)
    
    if (n == 0)
        error('Legendre Polynomial of order 0 has no roots');
    elseif IsNotIntegral(n,'+')
        error('Given order ''n'' must be a strictly positive integer.');
    end
    
    switch(n)
        case(1)
            Roots   = 0;
            
        case(2)
            Roots   = sqrt(1/3)*([-1;1]);
            
        case(3)
            Roots   = sqrt(3/5)*[-1;0;1];
            
        case(4)
            c = sqrt(3/7 + 2/7*sqrt(6/5)*[1;-1]);
            Roots = [-c(1);-c(2);c(2);c(1)];
            
        case(5)
            c     = sqrt(245 + 14*sqrt(70)*[1;-1])/21   ;
            Roots = [-c(1);-c(2);0;c(2);c(1)]           ;
            
        otherwise
            d = (0:n)';
            a = (d+1)./(2*d+1);
            b = 0*a;
            c = d./(2*d+1);
            Roots   = GolubWelschPartial(a,b,c);
            Roots   = newtonCorrection(Roots,n);

    end
    

    function nodes = newtonCorrection(nodes,n)
        iter     = 0    ;
        iterMax  = 10   ;
        absTol   = eps();
        
        [Pn,DPn] = Legendre(nodes,n);
        dnode    = Pn./DPn          ;
        
        notDone = (norm(dnode,Inf) > absTol) & (iter < iterMax);
        while notDone
            nodes    = nodes - dnode    ;
            [Pn,DPn] = Legendre(nodes,n);
            dnode    = Pn./DPn          ;
            iter     = iter + 1         ;
            
            notDone  = (norm(dnode,Inf) > absTol) & (iter < iterMax);
        end
    end

end