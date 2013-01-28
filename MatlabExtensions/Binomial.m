function BinomialCoeff = Binomial(n,k)
	
    BinomialCoeff = 1;
    
    for m = 0 : (k - 1)
        BinomialCoeff = BinomialCoeff * (n-m) / (k-m);
    end
    
    
end