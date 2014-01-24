function ySol = SuccessiveApproximations(x,F,y0)

    Tolerance = 1E-10;
    NotDone   = true;
    yk      = 0*x + y0;
    
    while NotDone
        ykp1 = y0 + F(x,yk);
        
        Error   = norm(ykp1-yk)/norm(yk);
        NotDone = Error > Tolerance;
        yk      = ykp1;
    end
    
    ySol = ykp1;

end


