function [Nodes,Weights] = GaussLegendreSet(n)
    % ------------------------------------------------------------------------------
    %  Find the nodes and weights for a Gauss-Legendre Quadrature integration.
    %  Nodes   = Roots of Nth order Legendre Polynomial
    %
    %                        2
    %  Weights = --------------------------- ; (Abramowitz & Stegun 1972, p.887)
    %             (1-Node^2)*[dPdx(Nodes)^2]
    %

    if (n == 0)
        error('There is no Gauss-Legendre rule of order 0.');
    elseif IsNotIntegral(n,'+')
        error('Given order ''n'' must be a strictly positive integer.');
    end
    
    
    %   Get the nodes from the roots function
    Nodes = LegendreRoots(n);

    
    %   Calculate the weights
    switch(n)
        case(1)
            Weights = 2;

        case(2)
            Weights = [1;1];

        case(3)
            Weights = [5;8;5]/9;

        case(4)
            c       = (18 + sqrt(30)*[1;-1])/36 ;
            Weights = [-c(1);-c(2);c(2);c(1)]   ;

        case(5)
            c       = (322 + 13*sqrt(70)*[-1;1])/900    ;
            Weights = [c(1);c(2);128/225;c(2);c(1)]     ;

        otherwise
            Weights = 2/(n+1)^2*(1-Nodes.^2)./(Legendre(Nodes,n+1).^2);

    end
    
end