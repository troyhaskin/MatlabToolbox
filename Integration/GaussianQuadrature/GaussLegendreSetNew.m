function [Nodes,Weights] = GaussLegendreSetNew(N)
    % ------------------------------------------------------------------------------
    %  Find the nodes and weights for a Gauss-Legendre Quadrature integration.
    %  Nodes   = Roots of Nth order Legendre Polynomial
    %
    %                        2
    %  Weights = --------------------------- ; (Abramowitz & Stegun 1972, p.887)
    %             (1-Node^2)*[dPdx(Nodes)^2]
    %
    
    switch(N)
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
            n = (0:N)';
            a = (n+1)./(2*n+1);
            b = 0*a;
            c = n./(2*n+1);
            Nodes   = GolubWelschPartial(a,b,c);
            Weights = 2/(N+1)^2*(1-Nodes.^2)./(Legendre(Nodes,N+1).^2);
    end
    
    %   End of Main Program
    % ------------------------------------------------------------------------------
end