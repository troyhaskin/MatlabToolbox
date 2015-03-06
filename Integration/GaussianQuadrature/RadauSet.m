function [nodes,weights] = RadauSet(n)
    
    %   Initial guess (Chebyshev nodes)
    nodes = cos((2*(n-1:-1:1)'-1)/(2*n)*pi);
    
    %   Prepare for Aberth iterations
    iter     = 0    ;
    iterMax  = 100  ;
    absTol   = eps();
    
    %   Initial Aberth update
    [Pn,DPn,~,Pnm1,~,DPnm1] = Legendre(nodes,n)                     ;
    r     = (Pnm1 + Pn)./(1+nodes)                                  ;
    dr    = (DPnm1 + DPn - r)./(1+nodes)                            ;
    rodr  = r./dr                                                   ;
    dnode = rodr./(1 - rodr .* sum(bsxfun(@minus,nodes,nodes'),2))  ;
    
    notDone = (norm(dnode,Inf) > absTol) & (iter < iterMax);
    while notDone
        %   Shift nodes
        nodes    = nodes - dnode    ;
        
        %   Computer Aberth update
        [Pn,DPn,~,Pnm1,~,DPnm1] = Legendre(nodes,n)                     ;
        r     = (Pnm1 + Pn)./(1+nodes)                                  ;
        dr    = (DPnm1 + DPn - r)./(1+nodes)                            ;
        rodr  = r./dr                                                   ;
        dnode = rodr./(1 - rodr .* sum(bsxfun(@minus,nodes,nodes'),2))  ;
        iter     = iter + 1         ;
        
        notDone  = (norm(dnode,Inf) > absTol) & (iter < iterMax);
    end
    
    %   Calculate weights
    weights = 1./((1-nodes).*DPnm1.^2);
    nodes   = [-1 ; nodes];
    weights = [2./n^2 ; weights] ; 
    
end

