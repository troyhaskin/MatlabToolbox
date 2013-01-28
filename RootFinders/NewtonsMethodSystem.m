function Solution = NewtonsMethodSystem(Guess,System,Jacobian)
    
    dxTolRel   = (1E-6)^2  ;
    dFTolAbs   = 100*eps() ;
    FTolAbs    = 100*eps() ;
	IterMax         = 1E1       ;
    NotDone         = true      ;
	Iter            = 0         ;
    
    xn	= Guess     ;
    F   = System    ;
    J   = Jacobian  ;
    
    while NotDone
              
        Jxn     = J(xn)         ;
        Fxn     = F(xn)         ;
        Update  = Jxn \ Fxn     ; % does not explicitly form Jxn^-1 => faster
        xnp1    = xn - Update   ;
        Fxnp1   = F(xnp1)       ;
        
        dxL2Rel = sum(( xnp1 -  xn).^2)/sum(xn.^2) ;
        dFL2Abs = sum((Fxnp1 - Fxn).^2)            ;
        
        dxAboveTol      = dxL2Rel > dxTolRel       	;
        dFAboveTol      = dFL2Abs > dFTolAbs       	;
        FNotNearZero    = any(abs(Fxnp1) > FTolAbs) ;
        
        NotConverged    = dxAboveTol || dFAboveTol || FNotNearZero  ;
        BelowIterMax    = IterMax > Iter                            ;
        NotDone         = NotConverged && BelowIterMax              ;
        
        xn      = xnp1      ;       
        Iter    = Iter + 1  ;
    end
    
    Solution = xnp1;
    
end

