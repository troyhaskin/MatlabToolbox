function B = SolveSystem(rho,phi,B,Tolerance)
    
    Nrho = size(rho,2);
    Nphi = size(phi,1);

    B    = B';
    Bnew = B;
    
    drho = rho(1,2) - rho(1,1);
    dphi = phi(2,1) - phi(1,1);
    
    i2drho = 1/(2*drho);
    idrho2 = 1/drho^2;
    idphi2 = 1/dphi^2;
    
    mu    = 1;
    sigma = 1;
    alpha =  1 ./(mu.*sigma.*rho);
    beta  = rho./(mu.*sigma);
    gamma = 1/(mu.*sigma) + rho*0;
    delta =  1./(2*alpha*idphi2 + 2*gamma*idrho2 + 1);
    
    alpha = alpha';
    beta  = beta';
    gamma = gamma';
    delta = delta';
    
    I = 2:Nrho-1;
    J = 2:Nphi-1;
    
    Im1 = 1:Nrho-2;
    Ip1 = 3:Nrho-0;
    
    Jm1 = 1:Nphi-2;
    Jp1 = 3:Nphi-0;
    
    NotDone = true;
    Iter    = 0;


    while NotDone
        
        Bnew(I,J) = ((gamma(Ip1,J)*idrho2 + beta(Ip1,J)*i2drho).*B(Ip1,J) + ...
                     (gamma(Im1,J)*idrho2 - beta(Im1,J)*i2drho).*B(Im1,J) + ...
                     (alpha(I,Jp1).*B(I,Jp1) + alpha(I,Jm1).*B(I,Jm1))*idphi2) .* delta(I,J)   ;
        
        Bnew(1,J) = (2*gamma(2,J).*B(2,J)*idrho2                                   + ...
                     (alpha(2,Jp1).*B(2,Jp1) + alpha(2,Jm1).*B(2,Jm1))*idphi2).* delta(1,J)           ;

        Bnew(Nrho,J) = (2*gamma(Nrho-1,J)  .*B(Nrho-1,J)*idrho2  + ...
                         (alpha(Nrho-1,Jp1).*B(Nrho-1,Jp1) + alpha(Nrho-1,Jm1).*B(Nrho-1,Jm1))*idphi2).*delta(Nrho,J) ;
        
        Error = norm(B-Bnew,1);
        B = Bnew;
        NotDone = Error > Tolerance;
        Iter    = Iter + 1;
        
%         if (Iter == 1) || not(NotDone)
            Show([Iter,Error]','%+17.6E');
%         end
    end
    
    B =B';
end

