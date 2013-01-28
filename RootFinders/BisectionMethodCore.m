function Roots = BisectionMethodCore(Fun,Neg,Pos,Tolerance,MaxIter)
    
    NotDone         = true                      ;
    Iter            = 0                         ;

    while NotDone
        
        MidPoint        = 0.5 * (Pos + Neg)                     ;
        FunMid          = Fun(MidPoint)                         ;            
        NoWork          = FilterFunctionValues()                ;
        NotConverged	= ~NoWork                               ;
        NotTooManyIters = Iter < MaxIter                        ;
        Iter            = Iter + 1                              ;
        NotDone         = any(NotConverged) && NotTooManyIters	;
        
        PosMid	= FunMid > 0   & NotConverged           ;
        Neg     = ~PosMid .* MidPoint +  PosMid .* Neg  ;
        Pos     =  PosMid .* MidPoint + ~PosMid .* Pos	;
    end
    
    Roots = FilterConvergedValues();


    function Filtered = FilterFunctionValues()
        ZeroCheck   = abs(FunMid) < Tolerance           ;
        NaNCheck    = isnan(FunMid)                     ;
        InfCheck    = isinf(FunMid)                     ;
        Filtered    = ZeroCheck | NaNCheck | InfCheck   ;
    end


    function Filtered = FilterConvergedValues()
        NaNCheck    = isnan(MidPoint)                           ;
        InfCheck    = isinf(MidPoint)                           ;
        Filtered    = MidPoint(NoWork & ~NaNCheck & ~InfCheck)	;
    end
    
end