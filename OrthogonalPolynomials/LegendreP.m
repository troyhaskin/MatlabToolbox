function Pl = LegendreP(x,l)
    
    Pkm1    = 1 + 0 * x     ;    % Zeroth order
    Pk      = x             ;    % First  order
    
    
    switch (l)
        case (0)
            Pl = Pkm1;
            
        case(1)
            Pl = Pk;
            
        otherwise
            
    	% --------------------------------------------------------------------
    	%   Enter recurrence calculation :
    	%
    	%	(n+1) P_{n+1}(x) = (2n+1) x P_{n}(x) - n P_{n-1}(x)
        %
            
        % Recurrence coefficients
            N  = (1:l);
            A1 = (2 * N + 1) ./ (N + 1);
            A2 = N ./ (N + 1);
            
        % Recurrence loop
            for k = 2:l
                Pkp1 = A1(k-1) .* x .* Pk - A2(k-1) .* Pkm1;
                Pkm1 = Pk;
                Pk   = Pkp1;
            end
            
         % Final output
            Pl = Pkp1;
    end
    
    
end