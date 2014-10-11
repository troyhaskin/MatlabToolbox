function En = ExponentialIntegralN(x,n)
    
    narginchk(2,2);
    
    CheckInputs = inputParser()                                                 ;
    CheckInputs.addRequired('x',@(t)(isvector(t) && isequal(real(t),t)))            ;
    CheckInputs.addRequired('n',@(t)(isscalar(t) && t>0 && IsIntegral(t,'+')))  ;
    CheckInputs.parse(x,n)                                                      ;
    
    En       = ExponentialIntegral(x);
    invCoeff = 1./(1:n-1);
    
    for k = 2:n
        En = (exp(-x) - x.*En) * invCoeff(k-1);
    end

    En(x==0) = 1/(n-1);
    
end