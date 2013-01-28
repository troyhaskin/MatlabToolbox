function BinomCoeff = NchooseK(n,k)
	
	LengthK	= length(k);
	
	if (LengthK > 1)
		BinomCoeff(LengthK)	= 0.0;
		
		for m = 1:LengthK
			BinomCoeff(m)	= nchoosek(n,k(m));
		end
	else
		BinomCoeff			= nchoosek(n,k);
	end
	
end