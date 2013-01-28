function Roots = LaguerreMethodDriver(Fun,DFun,DDFun,Nroots,Guess,Tolerance,MaxIter)
    
    NotDone         = true                  ;
    Iter            = 0                     ;

    while NotDone
        
        FunVal          = Fun(Guess)                            ;
        NoWork          = FilterFunctionValues()                ;
        NotConverged	= ~NoWork                               ;
        NotTooManyIters = Iter < MaxIter                        ;
        Iter            = Iter + 1                              ;
        NotDone         = any(NotConverged) && NotTooManyIters	;
        
        
        G           =        DFun(Guess(NotConverged))  ./ FunVal(NotConverged)	;
        H           = G.^2 - DDFun(Guess(NotConverged)) ./ FunVal(NotConverged)	;
        Term        = sqrt((Nroots-1)*(Nroots*H-G.^2))                          ;
        PlusSign	= abs(G+Term) > abs(G-Term)                                 ;
        Denom       = PlusSign.*(G+Term) + ~PlusSign.*(G-Term)                  ;
        a           = Nroots ./ Denom                                           ;
        
        Guess(NotConverged) = Guess(NotConverged) - a                           ;
    end
    
    Roots = FilterConvergedValues();


    function Filtered = FilterFunctionValues()
        ZeroCheck   = abs(FunVal) < Tolerance           ;
        NaNCheck    = isnan(FunVal)                     ;
        InfCheck    = isinf(FunVal)                     ;
        Filtered    = ZeroCheck | NaNCheck | InfCheck   ;
    end


    function Filtered = FilterConvergedValues()
        NaNCheck    = isnan(Guess)                          ;
        InfCheck    = isinf(Guess)                          ;
        Filtered    = Guess(NoWork & ~NaNCheck & ~InfCheck)	;
    end
    
end