function Ln = Laguerre(x,n,alpha)

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
    n    = 2:n;
    invk = 1./n;
    a1   = 2*n + alpha - 1;
    a2   =  -n - alpha + 1;
    
    % Recurrence loop
    for k = n-1
        Ln      = ( (a1(k) - x) .* Lnm1 + a2(k) * Lnm2) * invk(k)  ;
        Lnm2    = Lnm1 ;
        Lnm1    = Ln   ;
    end
    
    % Final output
    Ln(x==0)    = Binomial(n+alpha,n)   ;
    
end