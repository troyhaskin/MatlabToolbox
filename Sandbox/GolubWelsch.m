function [xk,wk] = GolubWelsch(ak,bk,ck)
    %GolubWelsch
    %   Calculate the approximate* nodes and weights (normalized to 1) of an orthogonal 
    %   polynomial family defined by a three-term reccurence relation of the form
    %       x pk(x) = ak pkp1(x) + bk pk(x) + ck pkm1(x)
    %
    
    %   Calculate the terms for the orthonormal version of the polynomials
    alpha = sqrt(ak(1:end-1) .* ck(2:end));
    
    %   Build the symmetric tridiagonal matrix
    T = diag(alpha,-1) + diag(bk) + diag(alpha,+1)  ;
    
    %   Calculate the eigenvectors and values of the matrix
    [V,L] = eig(T);
    
    %   The eigenvalues are the nodes (zeros) of the polynomials
    xk = diag(L);
    
    %   Calculate the weights from the eigenvectors - technically, Golub-Welsch requires
    %   a normalization, but since MATLAB returns unit eigenvectors, it is omitted.
    wk = (V(1,:).^2)';
    
end