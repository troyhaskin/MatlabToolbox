function xk = GolubWelschPartial(ak,bk,ck)
    %GolubWelschPartial
    %   Calculate the nodes of an orthogonal polynomial family defined by a three-term 
    %   reccurence relation of the form:
    %       x pk(x) = ak pkp1(x) + bk pk(x) + ck pkm1(x)
    %   
    %   The weights via the first eigenvector are not calculated for the partial implementation.
    %   This function should be used when an explicit forumla for the weights is needed since
    %   calculation of the eigenvectors does not scale linearly with the order of the recurrence
    %   relation.
    %
    
    %   Calculate the terms for the orthonormal version of the polynomials
    alpha = sqrt(ak(1:end-1) .* ck(2:end));
    
    %   Build the symmetric tridiagonal matrix
    T = spdiags([[alpha;0],bk,[0;alpha]],[-1,0,+1],length(alpha),length(alpha));
    
    %   Calculate the eigenvectors and values of the matrix
    xk = eig(full(T),'vector');
    
end