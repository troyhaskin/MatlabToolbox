function Roots = SecantMethodCore(Fun,DFun,Guess,Tolerance,MaxIter)
    
    NotDone         = true                      ;
    Iter            = 0                         ;
    Roots           = zeros(length(Guess),1)	;
    xk              = Guess                     ;
    
    while NotDone
        
        Values              = Fun(xk)             	;
        QNewtonUpdate       = Fun(xk) ./ DFun(xk)	;
        xk                  = xk - QNewtonUpdate    ;
        
        Converged           = ConvergenceTest(QNewtonUpdate,Values,Tolerance)	;
        BelowIterMax        = Iter < MaxIter                                    ;
        Iter                = Iter + 1                                          ;
        NotDone             = any(~Converged) && BelowIterMax                   ;
        
        Roots(Converged)    = xk(Converged)     ;
        xk                  = xk(~Converged)	;
    end
end


function Filtered = FilterFunctionValues(FunVals,Tolerance)
    ZeroCheck   = abs(FunVals) < Tolerance          ;
    NaNCheck    = isnan(FunVals)                    ;
    InfCheck    = isinf(FunVals)                    ;
    Filtered    = ZeroCheck | NaNCheck | InfCheck	;
end

function Converged = ConvergenceTest(Updates,Values,Tolerance)
    IsNan       = isnan(Values) | isnan(Updates)       	;
    IsInf       = isinf(Values) | isinf(Updates)        ;
    IsZero      = Values < Tolerance                    ;
    WontMove    = Updates < 10*eps()                    ;
    Converged	= IsZero & WontMove & IsNan & IsInf     ;
end