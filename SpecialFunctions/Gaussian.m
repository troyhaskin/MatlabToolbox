function PDF = Gaussian(x,mu,sigma)
	
	TwoSigSqr	= 2*sigma^2;
	PDF			= 1/sqrt(pi*TwoSigSqr) * exp(-(x-mu).^2/TwoSigSqr);
end