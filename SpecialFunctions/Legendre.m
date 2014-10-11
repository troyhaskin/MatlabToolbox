function Pn = Legendre(x,n)
    
    Pkm2 = 1 + 0 * x;    % Zeroth order
    Pkm1 = x        ;    % First  order
    
    
    switch (n)
        case (0)
            Pn = Pkm2;
            
        case (1)
            Pn = Pkm1;
            
        otherwise
            
            % --------------------------------------------------------------------
            %   Enter recurrence calculation :
            %
            %	k P_n = (2k - 1) x P_{k-1} - (k-1) P_{k-2}
            %
            
            % Recurrence coefficients
            n  = (2:n);
            a1 = (2*n - 1) ./ n ;
            a2 =  (1 - n)  ./ n ;
            
            % Recurrence loop
            for k = n-1
                Pn = a1(k) .* x .* Pkm1 + a2(k) .* Pkm2;
                Pkm2 = Pkm1;
                Pkm1 = Pn;
            end
    end
    
    
end