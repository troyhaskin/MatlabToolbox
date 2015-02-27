function [Nodes,Weights] = GaussLegendreSet(N,NormalizeTo)
	% ------------------------------------------------------------------------------
	%  Find the nodes and weights for a Gauss-Legendre Quadrature integration.
	%  Nodes   = Roots of Nth order Legendre Polynomial
	%
	%                        2
	%  Weights = --------------------------- ; (Abramowitz & Stegun 1972, p.887)
	%             (1-Node^2)*[dPdx(Nodes)^2]
	%
    
    if (nargin < 2) || isempty(NormalizeTo)
        NormalizeTo = 2;
    end
    
    n = 0:(N-1);
    a = (n+1)./(2*n+1);
    b = 0;
    c = n./(2*n+1);
    [Nodes,Weights] = GolubWelsch(a,b,c,NormalizeTo);
    
% %  Legacy
% 	Nodes	= LegendrePRoots(N)			    ; % Find the roots (nodes) of the set
% 	dPdx	= DLegendreP(Nodes,N)           ; % Derivative of Legendre Poly.
% 	Weights	= 2./((1-Nodes.^2).*dPdx.^2)    ; % Weight function -	normalized
% 	if (nargin > 1)
% 		Weights = Weights ./ sum(Weights) * NormalizeTo	; % Normalize to option
% 	end
	
	
	%   End of Main Program
	% ------------------------------------------------------------------------------
end