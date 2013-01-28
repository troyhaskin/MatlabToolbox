function [Q,R] = QRDecomposition(A)
    
    N  = length(A);
    I  = eye(N);
    Qk = I;
    Q  = I;
	Ap = A;
    
    for k = 1:N
        x     = Ap(k:N,k);
        alpha = sign(-x(1))*abs(norm(x,2));
        u  = x + alpha*I(k:N,k);
        v  = u / (norm(u,2) + eps());
        w = (x'*v)/(v'*x + eps());
        Qk(k:N,k:N) = I(k:N,k:N) - (1+w)*(v*v');
        Q  = Qk*Q;
        Ap = Q*Ap;
        Qk = I;
    end
    
    R = Q*A;
    Q = Q';
    
end