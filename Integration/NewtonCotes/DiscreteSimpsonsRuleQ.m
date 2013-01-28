function Integral = DiscreteSimpsonsRuleQ(Val,Phi)
%
% DiscreteSimpsonsRuleQ: Quick, discrete Simpson's rule
%
%	Performs Simpson's rule integration with no input checking (quick),
%	aside from a determination of the interval count being odd or even.
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
%	performed on all subsequent intervals.  For a coarse mesh, this may cause
%	errors to seep in.
%
%	Author  : Troy Haskin
%	Created : 12 / 17 / 2009
%	Version : 1.0

	[End,Nsets] = size(Phi)   ; %#ok<NASGU>
	Codd        = 1.0 / 6.0   ;
	Cevn        = 4.0 / 6.0   ;
	Ctrp        = 0.5         ;
	
	if (End == 2)
		Integral = 0.5 * (Val(2,:) - Val(1,:)) * sum(Phi,1);
		return;
	end
	
	
	switch(mod(End,2))
		case(1)
			Iodd = 3:2:End-2   ;
			Ievn = 2:2:End-1   ;

			Weights( 1,: )  = Codd * (Val(3,:)      - Val(1,:)      ) ;
			Weights(End,:)  = Codd * (Val(End,:)    - Val(End-2,:)  ) ;
			Weights(Iodd,:) = Codd * (Val(Iodd+2,:) - Val(Iodd-2,:) ) ;
			Weights(Ievn,:) = Cevn * (Val(Ievn+1,:) - Val(Ievn-1,:) ) ;

            Integral = 0.0;
            
            for k = 1:End
                Integral = Integral + Weights(k,:) .* Phi(k,:);
            end

		case(0)
			Iodd = 4:2:End-2   ;
			Ievn = 3:2:End-1   ;

			Weights(1,:)    = Ctrp * (Val(2,:)      - Val(1,:)      ) ;
			WeightsSimp     = Codd * (Val(4,:)      - Val(2,:)      ) ;
			Weights(End,:)  = Codd * (Val(End,:)    - Val(End-2,:)  ) ;
			Weights(Iodd,:) = Codd * (Val(Iodd+2,:) - Val(Iodd-2,:) ) ;
			Weights(Ievn,:) = Cevn * (Val(Ievn+1,:) - Val(Ievn-1,:) ) ;
			Weights(2,:)    = Weights(1,:) + WeightsSimp              ;

            Integral = 0.0;
            
            for k = 1:End
                Integral = Integral + Weights(k,:) .* Phi(k,:);
            end
	end
end