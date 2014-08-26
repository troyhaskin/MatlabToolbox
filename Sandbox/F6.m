function b = F6(x,N,Nall)
    
    
    persistent A B C D E F
    
    if isempty(A)
        A = magic(Nall);
        B = A;
        C = A;
        D = A;
        E = A;
        F = A;
    end
    
    for k = 1:N
        b = (A*B*C*D*E*F)*x;
    end
    
end