function Integral = TrapezoidalRuleQCS(Dx,Phi)
	%
	% TrapezoidalRuleQCS: Quick trapezoidal rule for constant spacing
	%
	%	Performs trapezoidal rule integration with no input checking (quick).
	%	Dx must be a scalar value (or a dimension mismtach may arise).  Phi is
	%	expected to be a column vector of two or more elements.
	%
	%
	%	Author  : Troy Haskin
	%	Created : 12 / 17 / 2009
	%	Version : Original
	
	[End,Nsets] = size(Phi)                                  ;
	Weights     = (ones(Nsets,1) * [0.5,ones(1,End-2),0.5])' ;
	Integral    = Dx * sum(Weights .* Phi)                   ;
	
end
