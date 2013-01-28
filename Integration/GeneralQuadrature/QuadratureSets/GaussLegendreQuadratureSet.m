function [Nodes,Weights] = GaussLegendreQuadratureSet(N,NormalizeTo)
	% ------------------------------------------------------------------------------
	%  Find the nodes and weights for a Gauss-Legendre Quadrature integration.
	%  Nodes   = Roots of Nth order Legendre Polynomial
	%
	%                        1
	%  Weights = --------------------------- ; (Abramowitz & Stegun 1972, p.887)
	%             (1-Node^2)*[P'n(Nodes)^2]
	%
	%  The numerator coefficient has been changed from 2 -> 1 for normalization.
	%
	
	Nodes	= LegendrePRoots(N)			    ; % Find the roots (nodes) of the set
	dPdx	= DLegendreP(Nodes,N)           ; % Derivative of Legendre Poly.
	Weights	= 1./((1-Nodes.^2).*dPdx.^2)    ; % Weight function -	normalized
											  %						to one
	
	if (nargin > 1)
		Weights = Weights ./ sum(Weights) * NormalizeTo	; % Normalize to option
	end
	
	
	%   End of Main Program
	% ------------------------------------------------------------------------------
end