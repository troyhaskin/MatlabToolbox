function y = GeneralizedContinuedFraction(b0,b1,a1,an,bn,x)

%GeneralizedContinuedFraction
%   Purpose:
%       Evalute a continued fraction via the Modified Lentz Method.
%   Source:
%       Book:       Numerical Recipes in C: The Art of Scientific Computing
%       Chapter:    5
%       Section:    5.2 Evaluation of Continued Fractions
%   Form:
%                             a1
%       y = bo + -----------------------------
%                                a2
%                 b1 + -----------------------
%                                   a3
%                       b2 + -----------------
%                                     a4
%                             b3 + -----------
%                                   b4 + ....


    % Initialization and allocation
    Zeros = x * 0       ;
    y     = b0 + Zeros  ;
    bk    = b1 + Zeros  ;
    ak    = a1 + Zeros  ;
    Dkm1  = Zeros       ; 
    Ckm1  = y           ;
    Dk    = Zeros       ;
    Ck    = Zeros       ;
    delta = Zeros       ;
    
    if isscalar(bk)
        bkMask = @(scalar,Mask) GetScalar(scalar,Mask);
    else
        bkMask = @(vector,Mask) vector(Mask);
    end
    
    if isscalar(ak)
        akMask = @(scalar,Mask) GetScalar(scalar,Mask);
    else
        akMask = @(vector,Mask) vector(Mask);
    end
    
    Tiny = 1E-30;
    n    = 2    ;
    
    NotDone           = true        ;
    IterationMaximum  = 10000       ;
    RelativeTolerance = 100*eps()	;
    NotConverged      = Zeros < 1   ;
    
    b0IsZero       = (y == 0)   ;
    y   (b0IsZero) = Tiny       ;
    Ckm1(b0IsZero) = Tiny       ;
    
    while NotDone
        
        Dk(NotConverged) = bk(NotConverged) + ak(NotConverged) .* Dkm1(NotConverged);
        
        Dk(abs(Dk) == 0) = Tiny   ;
        Dk(NotConverged) = 1 ./ Dk(NotConverged);

        Ck(NotConverged) = bkMask(bk, NotConverged) + akMask(ak,NotConverged)./Ckm1(NotConverged);
        Ck(abs(Ck) == 0) = Tiny ;

        delta(NotConverged) = Ck(NotConverged)    .* Dk(NotConverged)   ;
        y(NotConverged)     = delta(NotConverged) .* y(NotConverged)    ;
        
        
        NotConverged          = abs(delta - 1) > RelativeTolerance          ;
        BelowIterationMaximum = n < IterationMaximum                        ;
        NotDone               = any(NotConverged) & BelowIterationMaximum   ;
        
        if NotDone
            ak   = an(n)    ;
            bk   = bn(n)    ;
            Dkm1 = Dk       ;
            Ckm1 = Ck       ;
            n    = n + 1    ;
            
            if (n == 2)
                if isscalar(bk)
                    bkMask = @(scalar,Mask) scalar;
                else
                    bkMask = @(vector,Mask) vector(Mask);
                end
                
                if isscalar(ak)
                    akMask = @(scalar,Mask) scalar;
                else
                    akMask = @(vector,Mask) vector(Mask);
                end
            end
        end
        
    end
    
    Show(n);
    
end


function ScalarOut = GetScalar(ScalarIn,Mask)
    if any(Mask)
        ScalarOut = ScalarIn;
    else
        ScalarOut = zeros(0,1);
    end
end
