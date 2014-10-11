function [Nodes,Weights] = GaussLaguerreSet(N,alpha)
% ------------------------------------------------------------------------------
%  Find the nodes and weights for a Gauss-Laguerre Quadrature integration.
%  Nodes   = Roots of Nth order Laguerre Polynomial
%
%                       Nodes
%  Weights = --------------------------- ; (Abramowitz & Stegun 1972, p.887)
%             (N+1)^2*[L_(n+1}(Nodes)^2]
%
    if (nargin < 2)
        alpha = 0;
    end
    
    %   Calculate the required recurrence terms
    k  = 0:(N-1);
    ak = -(k+1);
    bk = (2*k + 1 + alpha);
    ck = -(k + alpha);
    
    %   Calculate the weights
    if (alpha == 0)
        [Nodes,Weights] = GolubWelsch(ak,bk,ck,1);
    elseif (round(alpha) == alpha)
        [Nodes,Weights] = GolubWelsch(ak,bk,ck,factorial(alpha));
    else
        [Nodes,Weights] = GolubWelsch(ak,bk,ck,gamma(alpha+1));
    end
    
%   End of Main Program
% ------------------------------------------------------------------------------
end