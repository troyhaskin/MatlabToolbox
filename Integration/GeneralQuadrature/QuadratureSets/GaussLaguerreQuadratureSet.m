function [Nodes,Weights] = GaussLaguerreQuadratureSet(N,NormalizeTo)
% ------------------------------------------------------------------------------
%  Find the nodes and weights for a Gauss-Laguerre Quadrature integration.
%  Nodes   = Roots of Nth order Laguerre Polynomial
%
%                       Nodes
%  Weights = --------------------------- ; (Abramowitz & Stegun 1972, p.887)
%             (N+1)^2*[L_(n+1}(Nodes)^2]
%
    if (nargin < 2)
        NormalizeTo = 1;
    end
    
    
    Nodes	= FindLaguerrePRoots(N)  ; % Find the roots (nodes) of the set
    Lnp1	= @(x)GetLaguerreP(x,N+1); % Get the Nth L.P. function pointer
    Weights	= Nodes ./ (Lnp1(Nodes).^2) / (N+1)^2;
    
    if (nargin > 1)
        Weights = Weights ./ sum(Weights) * NormalizeTo	; % Normalize to option
    end
    
%   End of Main Program
% ------------------------------------------------------------------------------
end