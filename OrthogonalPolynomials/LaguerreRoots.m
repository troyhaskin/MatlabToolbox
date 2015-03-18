function roots = LaguerreRoots(n,alpha)
    
    if (n == 0)
        error('Laguerre Polynomial of order 0 has no roots');
    elseif IsNotIntegral(n,'+')
        error('Given order ''n'' must be a strictly positive integer.');
    end
    
    switch(n)
        case(1)
            roots = 1;
            
        case(2)
            roots = 2 + sqrt(2)*[-1;1];
            
        otherwise
            k     = (0:n)'                      ;
            a     = -(k+1)                      ;
            b     = (2*k + 1 + alpha)           ;
            c     = -(k + alpha)                ;
            roots = GolubWelschPartial(a,b,c)   ;
%             roots   = newtonCorrection(roots,n,alpha);

    end
    

%     function nodes = newtonCorrection(nodes,n,alpha)
%         iter     = 0    ;
%         iterMax  = 10   ;
%         absTol   = eps();
%         
%         [Pn,DPn] = Laguerre(nodes,n,alpha);
%         dnode    = Pn./DPn          ;
%         
%         notDone = (norm(dnode,Inf) > absTol) & (iter < iterMax);
%         while notDone
%             nodes    = nodes - dnode    ;
%             [Pn,DPn] = Legendre(nodes,n);
%             dnode    = Pn./DPn          ;
%             iter     = iter + 1         ;
%             
%             notDone  = (norm(dnode,Inf) > absTol) & (iter < iterMax);
%         end
%     end

end