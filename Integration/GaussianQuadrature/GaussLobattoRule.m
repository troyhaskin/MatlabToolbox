function [nodes,weights] = GaussLobattoRule(n)
    
    
    if (n == 1) || (n == 0)
        error('There is no Gauss-Lobatto rule below order 2.');
    elseif IsNotIntegral(n,'+')
        error('Given order ''n'' must be a strictly positive integer.');
    end
    
    
    
    %   Calculate the weights
    switch(n)
        case(2)
            nodes   = [-1;1];
            weights = [1;1] ;

        case(3)
            nodes   = [-1;0;1]  ;
            weights = [1;4;1]/3 ;

        case(4)
            nodes   = [-1;sqrt(5)/5*[-1;1];1]   ;
            weights = [1;5;5;1]/6               ;

        case(5)
            c       = sqrt(21)/7        ;
            nodes   = [-1;-c;0;c;1]     ;
            weights = [9;49;64;49;9]/90 ;

        case(6)
            c       = sqrt((7+2*sqrt(7)*[1;-1])/21) ;
            nodes   = [-1;-c(1);-c(2);c(2);c(1);1]  ;
            c       = (14 + sqrt(7)*[-1;1])         ;
            weights = [2;c(1);c(2);c(2);c(1);2]/30  ;

        otherwise
            %   Get guess from middle of n-th Legendre roots
            nodes = LegendreRoots(n-1)                  ; 
            nodes = (nodes(1:end-1) + nodes(2:end))/2   ;
            
            %   Correct guess using Newton-iteration
            [nodes,values] = newtonCorrection(nodes,n-1);
            nodes = [-1;nodes;1];
            
            %   Calculate weights
            weight  = 2/(n*(n-1));
            weights = [weight ; weight./values.^2 ; weight];
            

    end
    
    
    function [nodes,Pn] = newtonCorrection(nodes,n)
        iter     = 0    ;
        iterMax  = 100  ;
        absTol   = eps();
        
        [Pn,DPn,DDPn] = Legendre(nodes,n)   ;
        dnode         = DPn./DDPn           ;
        
        notDone = (norm(dnode,Inf) > absTol) & (iter < iterMax);
        while notDone
            nodes         = nodes - dnode       ;
            [Pn,DPn,DDPn] = Legendre(nodes,n)   ;
            dnode         = DPn./DDPn           ;
            iter          = iter + 1            ;
            
            notDone  = (norm(dnode,Inf) > absTol) & (iter < iterMax);
        end
    end
    
    
    
end