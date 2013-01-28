function Integral = TrapezoidalRuleQVV(Val,Phi)
	%
	% TrapezoidalRuleQVS: Quick trapezoidal rule for a vector of values
	%
	%	Performs trapezoidal rule integration with no input checking (quick).
	%	Val must be a column vector of values (not spacings) that has the same
	%	number of elements of Phi (or a dimension mismtach may arise). Phi is
	%	expected to be a column vector that has the same number of elements of
	%	Val (or a dimension mismtach may arise).
	%
	%
	%	Author  : Troy Haskin
	%	Created : 12 / 17 / 2009
	%	Version : Original
	
	End            = length(Phi)               ;
	
	if (End > 1)
		I              = 2 : End -1                ;
		Weights(End,1) = Val(End) - Val(End-1)     ;
		Weights(1,1)   = Val( 2 ) - Val(  1  )     ;
		Weights(I)     = Val(I+1) - Val( I-1 )     ;
		Integral       = 0.5 * sum(Weights .* Phi) ;
	else
		Integral = 0.0;
	end
	
end