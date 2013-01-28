function Roots = LegendrePRoots(L)
    
    if (L == 0)
        error('Legendre Polynomial of order 0 has no roots')                   ;
    elseif(L == 1)
        Roots = 0.0                                                             ;  % no work needed
        return                                                                  ;
    end
    
    LoTol	= 1E-12;
    HiTol	= 5E-16; %#ok<NASGU>
    MaxIter = 1E3;
    
    Pl                  = @(x) LegendreP(x,L)   ;
    DPl                 = @(x) DLegendreP(x,L)  ;
    DDPl                = @(x) DDLegendreP(x,L)	;
    k                   = 1                     ;
    NotDone             = true                  ;
    PositiveRootCount   = floor(L/2)            ;
    
    while NotDone
        Guess           = GeometricSpace(0,1,0.9970,2*k*L)                          ;
        Roots_Iterant   = LaguerreMethodCore(Pl,DPl,DDPl,L/2,Guess,LoTol,MaxIter) ;
        Roots_Iterant   = AllVectorUniques(Roots_Iterant,LoTol)                     ;
        Roots_Iterant   = FilterSmallComplexNums(Roots_Iterant,LoTol)               ;
        k               = k + 1                                                     ;
        NotDone         = ((sum(Roots_Iterant>0)) ~= PositiveRootCount)             ;
    end
    
    if (mod(L,2) == 0)
        Roots = [-Roots_Iterant(end:-1:1);Roots_Iterant];
    else
        Roots = [-Roots_Iterant(end:-1:1); 0 ;Roots_Iterant];
    end

end