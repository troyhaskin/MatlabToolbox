function Ln = LaguerreP(x,n,alpha)

    if (nargin < 3)
        alpha = 0;
    end
    
    Lnm2 = x ./ x           ; % Zeroth order, this form preserves the input shape of x.
    Lnm1 = 1 + alpha - x    ; % First  order
    
    % Low order escapes
    if (n == 0);
        Ln = Lnm2;
        return;
    elseif(n == 1)
        Ln = Lnm1;
        return;
    end

    
    % --------------------------------------------------------------------
    %   Enter recurrence calculation :
    %
    %	n L^{a}_{n+1}(x) = (2n + alpha-x-1) L^{a}_{n}(x) - (n-1+a) L^{a}_{n-1}(x)
    %
    
    % Recurrence coefficients
    OneOverK = 1 ./ (1:n);
    alphax1  = alpha - x - 1;
    
    % Recurrence loop
    for k = 2:n
        Ln      = ((2*k + alphax1) .* Lnm1 - (k - 1 + alpha) * Lnm2) * OneOverK(k)  ;
        Lnm2    = Lnm1 ;
        Lnm1    = Ln   ;
    end
    
    % Final output
    Ln(x==0)    = Binomial(n+alpha,n)   ;
    
end