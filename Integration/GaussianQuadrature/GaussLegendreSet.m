function [Nodes,Weights] = GaussLegendreSet(n)
    % ------------------------------------------------------------------------------
    %  Find the nodes and weights for a Gauss-Legendre Quadrature integration.
    %  Nodes   = Roots of Nth order Legendre Polynomial
    %
    %                        2
    %  Weights = --------------------------- ; (Abramowitz & Stegun 1972, p.887)
    %             (1-Node^2)*[dPdx(Nodes)^2]
    %
    
    switch(n)
        case(1)
            Nodes   = 0;
            Weights = 2;
            
        case(2)
            Nodes   = sqrt(1/3)*([-1;1]);
            Weights = [1;1]             ;
            
        case(3)
            Nodes   = sqrt(3/5)*[-1;0;1];
            Weights = [5/9;8/9;5/9]     ;
            
        case(4)
            c = 2/7*sqrt(6/5);
            cHi = sqrt(3/7 + c);
            cLo = sqrt(3/7 - c);
            Nodes = [-cHi;-cLo;cLo;cHi];

            c   = sqrt(30);
            cHi = (18 - c)/36;
            cLo = (18 + c)/36;
            Weights = [cHi;cLo;cLo;cHi];
            
        otherwise
            d = (0:n)';
            a = (d+1)./(2*d+1);
            b = 0*a;
            c = d./(2*d+1);
            Nodes   = GolubWelschPartial(a,b,c);
            Nodes   = newtonCorrection(Nodes,n);
            Weights = 2/(n+1)^2*(1-Nodes.^2)./(Legendre(Nodes,n+1).^2);
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