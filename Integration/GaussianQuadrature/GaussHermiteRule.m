function [nodes,weights] = GaussHermiteRule(n)
    % ------------------------------------------------------------------------------
    %  Find the nodes and weights for a Gauss-Hermite Quadrature integration.
    %

    if (n < 1)
        error('There is no Gauss-Hermite rule of order 0.');
    elseif  (n < 0) || (abs(n - round(n)) > eps())
        error('Given order ''n'' must be a strictly positive integer.');
    else
        n = round(n);
    end
    
    %   Get the nodes and weights from the Golub-Welsch function
    n = (0:n)'  ;
    b = n*0     ;
    a = b + 0.5 ;
    c = n       ;
    [nodes,weights] = GolubWelsch(a,b,c,sqrt(pi));
    
end