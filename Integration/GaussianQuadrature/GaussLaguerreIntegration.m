function I = GaussLaguerreIntegration(f,n,alpha)
    if (nargin < 3)
        alpha = 0;
    end
    
    [xi,wi] = GaussLaguerreRule(n,alpha);
    I = sum(wi .* f(xi));
end