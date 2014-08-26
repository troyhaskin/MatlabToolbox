function [F1,F2,F3,F4in] = Closure(N)
    
    A = magic(N);
    B = A;
    C = A;
    D = A;
    E = A;
    F = A;
    
    F1  = @(x)   Closure1(x);
    F2  = @(x)   Closure2(A,B,C,D,E,F,x);
    F3  = @(x)   Closure3(A,B,C,D,E,F,x);
    F4in  = F4(A,B,C,D,E,F);
    
    function b = Closure1(x)
        b = (A*B*C*D*E*F)*x;
    end
    
    function b = Closure2(A,B,C,D,E,F,x)
        b = (A*B*C*D*E*F)*x;
    end
    
    
end

function b = Closure3(A,B,C,D,E,F,x)
    b = (A*B*C*D*E*F)*x;
end