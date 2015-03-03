function xk = GolubWelschPartial(ak,bk,ck)
    %GolubWelschPartial
    %   Calculate the approximate* nodes and weights (normalized to 1) of an orthogonal 
    %   polynomial family defined by a three-term reccurence relation of the form
    %       x pk(x) = ak pkp1(x) + bk pk(x) + ck pkm1(x)
    %   
    %   The weight scale factor mu0 is the integral of the weight function over the
    %   orthogonal domain.
    %
    
    %   Calculate the terms for the orthonormal version of the polynomials
    alpha = sqrt(ak(1:end-1) .* ck(2:end));
    
    %   Build the symmetric tridiagonal matrix
    T = full(spdiags([[alpha;0],bk,[0;alpha]],[-1,0,+1],length(alpha),length(alpha)));
    
    %   Calculate the eigenvectors and values of the matrix
    xk = eig(T,'vector');
    
end