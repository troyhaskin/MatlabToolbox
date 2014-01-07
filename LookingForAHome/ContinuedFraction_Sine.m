function y = SineByCF(x)
    
    b0 = 0;
    b1 = 1;
    bn = @(n) (2*n-2) * (2*n - 1) - x.^2;
    
    a1 = x;
    an = @(n)  GetAn(n,x);
    
    y = GeneralizedContinuedFraction(b0,b1,a1,an,bn,x);
    
end

function an = GetAn(n,x)
    
    if n > 2
        an = (2*n-4) * (2*n-3) * x.^2;
    else
        an = x.^2;
    end
    
end