function Soln = ThomasSolve(Lower,Diag,Upper,R)
	
	End			= length(Diag)	;
	Cmod(End,1)	= 0.0			;
	Rmod(End,1)	= 0.0			;
	
	Cmod(1) = Upper(1)/Diag(1);
	Rmod(1) = R(1)/Diag(1);
	
	for k = 2:End
        invTerm = 1 / (Diag(k) - Cmod(k-1)*Lower(k))        ;
        Cmod(k) = Upper(k) * invTerm                        ;
		Rmod(k) = (R(k) - Rmod(k-1)*Lower(k)) * invTerm     ;
	end
	
	
	Soln(End,1) = Rmod(End);
    
	for k=End-1:-1:1
		Soln(k) = Rmod(k) - Cmod(k)*Soln(k+1);
	end
	
end