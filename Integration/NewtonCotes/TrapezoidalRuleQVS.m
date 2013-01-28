function Integral = TrapezoidalRuleQVS(Dx,Phi)
	%
	% TrapezoidalRuleQVS: Quick trapezoidal rule for a vector of spacings
	%
	%	Performs trapezoidal rule integration with no input checking (quick).
	%	Dx must be a column vector of spacings that has one less element than
	%	Phi (or a dimension mismtach may arise). Phi is expected to be a column
	%	vector of two or more elements.
	%
	%
	%	Author  : Troy Haskin
	%	Created : 12 / 17 / 2009
	%	Version : Original
	
	Endp     = length(Phi)                        ;
	Endd     = Endp - 1                           ;
	L        = 1:Endd - 1                         ;
	R        = L + 1                              ;
	Dx       = Dx'                                ;
	Weights  = 0.5 * [Dx(1),Dx(L)+Dx(R),Dx(Endd)] ;
	Integral = Weights * Phi                      ;
	
end