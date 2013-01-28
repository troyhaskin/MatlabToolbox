function Ll = GetLaguerreP(x,l,alpha)
    
    Lnm2    = x ./ x                ;    % Zeroth order, this form preserves
                                         % the input shape of x.

    Lnm1    = (alpha+1) - x         ;    % First  order
    
    if (l == 0);
        Ll = Lnm2;
        return;
    elseif(l == 1)
        Ll = Lnm1;
        return;
    end
    
    if (nargin < 3)
        alpha = 0;
    end
    
    % --------------------------------------------------------------------
    %   Enter recurrence calculation :
    %
    %	n L^{a}_{n+1}(x) = (2n-1-x+a) L^{a}_{n}(x) - (n-1+a) L^{a}_{n-1}(x)
    %
    
    % Recurrence coefficients
    OneOverK = 1 ./ (1:l);
    
    % Recurrence loop
    for k = 2:l
        C1      = 2*k - 1 + alpha - x                       ;
        C2      = k   - 1 + alpha                           ;
        Ln      = (C1 .* Lnm1 - C2 * Lnm2) * OneOverK(k)    ;
        Lnm2    = Lnm1                                      ;
        Lnm1    = Ln                                        ;
    end
    
    % Final output
    Ll          = Ln                    ;
    Ll(x==0)    = Binomial(l+alpha,l)   ;
    
end