function Logical = IsIntegral(Number,DesiredSign)
	
	narginchk(1,2)              ;
    Type = WhatIsThis(Number)   ;
    
	switch(Type)
		case('numeric')
			if (nargin < 2)
                IsInteger   = abs(round(Number) - Number) < 100*eps(Number)     ;
				Logical     = IsInteger                                         ;
				
			elseif (strcmpi('+',DesiredSign))
                IsInteger   = abs(round(Number) - Number) < 100*eps(Number)     ;
                IsPositive  = Number > 0                                        ;
				Logical     = IsInteger && IsPositive                           ;
				
			elseif (strcmpi('-',DesiredSign))
                IsInteger   = abs(round(Number) - Number) < 100*eps(Number)     ;
                IsNegative  = Number < 0                                        ;
				Logical     = IsInteger && IsNegative                           ;
				
			end
			
		otherwise
			error('Toolbox:IsIntegral:InvalidType'                              ,...
                'Numeric variable expected but received a ''%s''',Type)         ;
	end
	
end