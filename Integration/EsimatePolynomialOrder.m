function [Order,Error] = EsimatePolynomialOrder(Function,TestSeed)
	
	persistent ErrorTemp
	
	if (nargin < 2)
		TestSeed	= 5.0E5;
	end
		
	TestValues		= TestSeed:10^(log10(TestSeed)-3):1.50*TestSeed;
	Tolerance		= 1E-8 ;
	
	FunctionValues	= Function(TestValues);
	DerivativeOf	= Differentiate(TestValues,FunctionValues)';
	PossibleOrder	= mean(TestValues .* DerivativeOf ./ FunctionValues);
	ErrorTemp		= std(PossibleOrder);
	
	if any(isnan(FunctionValues) | (FunctionValues > 10E10))
		[Order,ErrorTemp] = EsimatePolynomialOrder(Function,0.5 * TestSeed);
	end
	
	if (ErrorTemp < Tolerance)
		Order = PossibleOrder - eps(ErrorTemp);
		Error = ErrorTemp					;
	end
	
end