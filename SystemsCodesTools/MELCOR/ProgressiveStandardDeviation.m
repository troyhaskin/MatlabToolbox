function ProgSigma = ProgressiveStandardDeviation(Data,StopAt)
	
	End = length(Data);
	
	if (nargin < 2)
		StopAt = End;
	elseif (nargin > 2)
		error('Too many inputs :: Only 1 or 2 argument may be given.');
	end
	
	
	TempOut		= Data(1:StopAt)	;
	DataMean	= mean(Data)		;
	invN		= 1 ./ (End : -1 : (End-StopAt));
	
	for k = 1:StopAt
		TempOut(k) = sqrt(sum((Data(k:End)-DataMean).^2)) .* invN(k) ;
	end
	
	ProgSigma = TempOut;
	
end