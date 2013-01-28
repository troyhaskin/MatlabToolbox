function Logical = IsRealScalar(Number,SignSensitive)
    
    error(nargchk(1,2,nargin))                                                  ;
    
    Type = WhatIsThis(Number)                                                   ;
    
    switch(Type)
        case('numeric')
            Logical = (real(Number) == Number) && (isscalar(Number))            ;
            
            if (nargin == 2)
                Pos      = strcmpi('+',SignSensitive)                           ;
                Neg      = strcmpi('-',SignSensitive)                           ;
                Logical  = Logical && ((Pos*Number > 0) || (Neg*Number < 0))    ;
            end
            
        otherwise
            error('Toolbox:IsRealScalar:InvalidType'                            ,...
                'Numeric variable expected but received a ''%s''',Type)         ;
    end
    
end