function [nodesG,weightsG,nK,wK] = GaussKronrodSet(N)
% ------------------------------------------------------------------------------
%  Find the nodes and weights for a Gauss-Laguerre Quadrature integration.
%  Nodes   = Roots of Nth order Laguerre Polynomial
%
%                       Nodes
%  Weights = --------------------------- ; (Abramowitz & Stegun 1972, p.887)
%             (N+1)^2*[L_(n+1}(Nodes)^2]
%
    if (nargin < 1) || isempty(N)
        N = 7;
    end
    
    %   Calculate Gauss-Legendre node-weight set
    n = 0:(N-1);
    a = (n+1)./(2*n+1);
    b = 0;
    c = n./(2*n+1);
    [nodesG,weightsG] = GolubWelsch(a,b,c,2);
    
    %
    nExtra = N+1;
    
end