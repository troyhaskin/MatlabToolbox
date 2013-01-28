function [V,D] = QRAlgorithm(A)
    
    Ak   = A;
    Qev  = eye(length(A));
    Tolerance = 1E-6;
    NotDone = true;
    
    while NotDone
        
        [Qk,Rk] = QRDecomposition(Ak);
        Akp1 = Rk*Qk;
        
        Qev = Qev*Qk;
        ErrorAbs = norm(Akp1-Ak,1)      ;
        ErrorRel = ErrorAbs/norm(Ak,1)  ;
        NotDone  = ErrorRel > Tolerance ;
        Ak = Akp1;
        
        Show(ErrorRel,'%13.7E');
    end
    
    V = Qk;
    D = diag(Rk);
    
end