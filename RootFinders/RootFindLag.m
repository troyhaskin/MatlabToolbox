function Root = RootFindLag(Fun,Nroots,Guesses)
    
    Dx      = 1E-2;
    DFun    = @(x) (Fun(x-2*Dx) -8*Fun(x-Dx) +8*Fun(x+Dx) -Fun(x+2*Dx)) /(12*Dx);
    DDFun   = @(x) (-Fun(x-2*Dx)+16*Fun(x-Dx)-30*Fun(x)+16*Fun(x+Dx)-Fun(x+2*Dx))/(12*Dx^2); 
    
    MaxIter	= 1E3   ;
    AbsTol	= 1E-14 ;
    
    if (nargin == 3)
        Guess     = Guesses                 ;
    else
        Guess     = (2 + 0.1i).^(1:Nroots)  ;
    end
    
    RawRoots = LaguerreMethodDriver(Fun,DFun,DDFun,Nroots,Guess,AbsTol,MaxIter)	;
    RawRoots = FilterSmallComplexNums(RawRoots,AbsTol)                          ;
    Root     = AllVectorUniques(RawRoots,AbsTol)                                ;
    
end