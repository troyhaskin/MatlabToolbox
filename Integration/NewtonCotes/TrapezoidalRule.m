function Integral = TrapezoidalRule(Spacing,Phi,n)
	
	
	
	if     (isscalar(Spacing) && nargin == 2)
		Integral = 0.5 * Spacing * (Phi(2) + Phi(1))                        ;
		
	elseif (isscalar(Spacing) && nargin == 3)
		Denom    = (n-1) * (  n   == length(Phi))                           +...
			         n   * ((n+1) == length(Phi))                           ;
		dx       = Spacing/Denom * ones(1,n)                                ;
		Integral = SpacingVectorIntegration()                               ;
		
	elseif ( length(Spacing) == length(Phi) )
		Lst      = length(Spacing)                                          ;
		dx       = Spacing(2:Lst) - Spacing(1:Lst-1)                        ;
		Integral = SpacingVectorIntegration()                               ;
		
	elseif (isvector(Spacing))
		dx       = Spacing                                                  ;
		Integral = SpacingVectorIntegration()                               ;
		
	else
		error('Unsupported set of input types passed to TrapezoidalRule.m') ;
	end
	
	
	
	function Int = SpacingVectorIntegration()
		End     = length(dx)       ;
		EndP    = length(Phi)      ;
		I       = 2:EndP - 1       ;
		dxLeft  = dx(1:End-1)      ;
		dxRight = dx(2: End )      ;
		dxLR    = dxLeft + dxRight ;
		Int     = 0.5 *( dx( 1 ) * Phi(1)     + ...
			             dx(End) * Phi(EndP)  + ...
			      sum(   dxLR   .* Phi(I))    );
	end
end