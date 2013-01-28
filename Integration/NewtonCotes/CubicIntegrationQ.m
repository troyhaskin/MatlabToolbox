function Integral = CubicIntegrationQ(Val,Phi)
%
% QuadIntegrationQ: Quick, cubic integration
%
%	Performs a generalization of Simpson's 3/8 rule for arbitrary indepedent
%	point placement with minimal input checking. A determination of the interval
%	count and the appropriate correction is applied.
%
%	Val must be a matrix with independent values (not spacings) in the columns
%	that has the same number of elements as Phi (or a dimension mismatch may 
%	arise). Phi must be a matrix with dependent values in the columns that has 
%	the same number of elements as Val (or a dimension mismtach may arise).
%
%	Integral is a row vector of the sums having the same number of columns as
%	Val and Phi.
%
%	For this quick function, an even number of intervals is handled via a
%	trapezoidal integration on the first interval with Simpson's Rule
%	performed on all subsequent intervals.  For a coarse mesh, this may cause
%	errors to seep in, but it not avoidable for the discrete case.
%
%	Author  : Troy Haskin
%	Created : 12 / 17 / 2009
%	Version : Original
%

	End  = size(Phi,1) ;
	C    = 1.0 / 12.0  ;
	
% 	if (End == 2)
% 		Integral = 0.5 * (Val(2,:) - Val(1,:)) * sum(Phi,1);
% 		return;
% 	end
	
	switch(mod(End-1,3))
		case(0)
			Imid1 = 2:3:End-2   ;
			Imid2 = 3:3:End-1   ;
			Iintn = 4:3:End-3   ;

			Weights(1,:)     = StartWeight(Val,1)                            ;
			Weights(End,:)   = EndWeight(Val,End)                            ;
			Weights(Imid1,:) = Mid1Weight(Val,Imid1)                         ;
			Weights(Imid2,:) = Mid2Weight(Val,Imid2)                         ;
			Weights(Iintn,:) = StartWeight(Val,Iintn) + EndWeight(Val,Iintn) ;

			Integral = sum(Weights .* Phi,1) ;

		case(1)
			IquadL =   1   :1:   3   ;
			IquadR = End-2 :1:  End  ;
			Icube  =   3   :1: End-2 ;
			Imid1  =   4   :3: End-4 ;
			Imid2  =   5   :3: End-3 ;
			Iintn  =   6   :3: End-5 ;
			
			Weights(1,:)       = StartWeight(Val,1)                            ;
			Weights(End-4,:)   = EndWeight(Val,End)                            ;
			Weights(Imid1-2,:) = Mid1Weight(Val,Imid1)                         ;
			Weights(Imid2-2,:) = Mid2Weight(Val,Imid2)                         ;
			Weights(Iintn-2,:) = StartWeight(Val,Iintn) + EndWeight(Val,Iintn) ;
			
			PartSumL = QuadraticIntegrationQ(Val(IquadL),Phi(IquadL))          ;
			PartSumR = QuadraticIntegrationQ(Val(IquadR),Phi(IquadR))          ;
			Integral = sum(Weights .* Phi(Icube),1) + PartSumL + PartSumR ;
			
		case(2)
			Iquad  =   1 :1:   3   ;
			Icube  =   3 :1:  End  ;
			Imid1  =   4 :3: End-2 ;
			Imid2  =   5 :3: End-1 ;
			Iintn  =   6 :3: End-3 ;
			
			Weights(1,:)       = StartWeight(Val,1)                            ;
			Weights(End-2,:)   = EndWeight(Val,End)                            ;
			Weights(Imid1-2,:) = Mid1Weight(Val,Imid1)                         ;
			Weights(Imid2-2,:) = Mid2Weight(Val,Imid2)                         ;
			Weights(Iintn-2,:) = StartWeight(Val,Iintn) + EndWeight(Val,Iintn) ;
			
			PartSum  = QuadraticIntegrationQ(Val(Iquad),Phi(Iquad)) ;
			Integral = sum(Weights .* Phi(Icube),1) + PartSum  ;
	end
	
	function Weight = StartWeight(V,P)
		a = V(P,:);		b = V(P+1,:);	c = V(P+2,:);	d = V(P+3,:)  ;
		Poly   = 3 * a.^2 + 6 * b .* c - 2 *  d .* ( b + c - a)       - ...
			                4 * a .* (b + c) + d.^2                   ;
		Weight = C * (d-a) .* Poly ./ ((a - b) .* (a - c))            ;
	end
	function Weight = Mid1Weight(V,P)
		a = V(P-1,:);	b = V(P,:);		c = V(P+1,:);	d = V(P+2,:)  ;

		Weight = - C * ( (a - d).^3 .*  (a - 2  * c + d)  )          ./ ...
			           ( (a - b)    .* (b - c) .* (b - d) )           ;
	end
	function Weight = Mid2Weight(V,P)
		a = V(P-2,:);	b = V(P-1,:);	c = V(P,:);		d = V(P+1,:)  ;

		Weight =   C * ( (a - d).^3 .*  (a - 2 * b + d)   )          ./ ...
			           ( (a - c)    .* (b - c) .* (c - d) )           ;
	end
	function Weight = EndWeight(V,P)
		a = V(P-3,:);	b = V(P-2,:);	c = V(P-1,:);	d = V(P,:)    ;
		Poly   = a.^2 + 6 * b .* c - 2 * a .* (b + c - d)             - ... 
			            4 * d .* (b + c) + 3 * d.^2                   ;
		Weight = C * (d-a) .* Poly ./ ((b - d) .* (c - d))            ;
	end
end