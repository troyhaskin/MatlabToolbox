function Integral = SimpsonsRulePure(h,Phi)
	[End,Nsets] = size(Phi) ;
	Codd        = h / 3.0   ;
	
	Iodd = 3:2:End-2 ;
	Ievn = 2:2:End-1 ;
	
	Weights(End ,1) = Codd       ;
	Weights( 1  ,1) = Codd       ;
	Weights(Iodd,1) = Codd * 2.0 ;
	Weights(Ievn,1) = Codd * 4.0 ;
	
	Integral(1,Nsets) = 0.0;
	
	for k = 1:Nsets
		Integral(k) = sum(Weights .* Phi(:,k),1);
	end
	
end