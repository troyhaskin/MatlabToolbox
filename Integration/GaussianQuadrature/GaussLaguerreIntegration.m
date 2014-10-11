function I = GaussLaguerreIntegration(f,N,alpha)
    if (nargin < 3)
        alpha = 0;
    end
    
    [xi,wi] = GaussLaguerreSet(N,alpha);
    I = sum(wi .* f(xi));
end