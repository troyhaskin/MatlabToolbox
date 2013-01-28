function Integral = QuadraticIntegrationQ(Val,Phi)
%
% QuadIntegrationQ: Quick, quadratic integration
%
%	Performs a generalization of Simpson's rule for arbitrary indepedent
%	point placement with no input checking (quick), aside from a determination 
%	of the interval count being odd or even.
%
%	Val must be a matrix with independent values (not spacings) in the columns
%	that has the same number of elements as Phi (or a dimension mismtach may 
%	arise). Phi must be a matrix with dependent values in the columns that has 
%	the same number of elements as Val (or a dimension mismtach may arise).
%
%	Integral is a row vector of the sums having the same number of columns as
%	Val and Phi.
%
%	For this quick function, an even number of intervals is handled via a
%	trapezoidal integration on the first interval with Simpson's Rule
%	performed on all subsequent intervals.  For a carse mesh, this may cause
%	errors to seep in, but it not avoidable for the discrete case.
%
%	Author  : Troy Haskin
%	Created : 12 / 17 / 2009
%	Version : Original

	[End,Nsets] = size(Phi)   ; %#ok<NASGU>
	C         = 1.0 / 6.0   ;
	Ctrp        = 0.5         ;
	
	if (End == 2)
		Integral = 0.5 * (Val(2,:) - Val(1,:)) * sum(Phi,1);
		return;
	end
	
	
	switch(mod(End,2))
		case(1)
			Iodd = 3:2:End-2   ;
			Ievn = 2:2:End-1   ;

			Weights(1,:)    = StartWeight(Val,1)                          ;
			Weights(End,:)  = EndWeight  (Val,End)                        ;
			Weights(Iodd,:) = StartWeight(Val,Iodd) + EndWeight(Val,Iodd) ;
			Weights(Ievn,:) = MidWeight  (Val,Ievn)                       ;

			Integral = sum(Weights .* Phi,1) ;

		case(0)
			Iodd = 4:2:End-2   ;
			Ievn = 3:2:End-1   ;

			Weights(1,:)    = Ctrp * (Val(2,:)      - Val(1,:)      ) ;
			WeightsSimp     = Codd * (Val(4,:)      - Val(2,:)      ) ;
			Weights(End,:)  = Codd * (Val(End,:)    - Val(End-2,:)  ) ;
			Weights(Iodd,:) = Codd * (Val(Iodd+2,:) - Val(Iodd-2,:) ) ;
			Weights(Ievn,:) = Cevn * (Val(Ievn+1,:) - Val(Ievn-1,:) ) ;
			Weights(2,:)    = Weights(1,:) + WeightsSimp              ;

			Integral      = sum(Weights .* Phi,1);
	end
	
	function Weight = StartWeight(Values,P)
		Weight = C * (Values(P+2,:)-Values(P,:))                   .* ...
			         (2*Values(P,:)-3*Values(P+1,:)+Values(P+2,:)) ./ ...
                     (Values(P,:)-Values(P+1,:))                   ;
	end
	function Weight = MidWeight(Values,P)
		Weight = -C * (Values(P-1,:) - Values(P+1,:)).^3           ./ ...
			         (Values(P-1,:) - Values(P,:))                 ./ ...
					 (Values(P,:) - Values(P+1,:))                 ;
	end
	function Weight = EndWeight(Values,P)
		Weight = -C * (Values(P,:)-Values(P-2,:))                  .* ...
			         (Values(P-2,:)-3*Values(P-1,:)+2*Values(P,:)) ./ ...
                     (Values(P-1,:)-Values(P,:))                   ;
	end
end