function [nodes,weights] = GaussLaguerreRule(n,alpha)
    % ------------------------------------------------------------------------------
    %  Find the nodes and weights for a Gauss-Laguerre integration.
    %  nodes = Roots of nth order Laguerre Polynomial
    %
    %                        2
    %  Weights = --------------------------- ; (Abramowitz & Stegun 1972, p.887)
    %             (1-Node^2)*[dPdx(Nodes)^2]
    %

    if (n == 0)
        error('There is no Gauss-Laguerre rule of order 0.');
    elseif IsNotIntegral(n,'+')
        error('Given order ''n'' must be a strictly positive integer.');
    end
    
    if (nargin < 2) || isempty(alpha)
        alpha = 0;
    end
    
    
    %   Get the nodes from the roots function
    nodes = LaguerreRoots(n,alpha);

    
    %   Calculate the weights
    switch(n)
        case(1)
            weights = 1;

        case(2)
            weights = (2 + sqrt(2)*[1;-1])/4;

        otherwise
            weights = gamma(n+alpha+1)/(gamma(n+1)*(n+1)^2) * nodes./(Laguerre(nodes,n+1,alpha).^2); 

    end
    
end