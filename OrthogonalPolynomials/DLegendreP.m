function DPl = DLegendreP(x,l)
    
    Pkm1    = 1.0 + 0 * x   ;    % Zeroth order
    Pk      = x             ;    % First  order
    
    
    switch (l)
        case (0)
            DPl = 0 * x ;
            
        case(1)
            DPl = Pkm1  ;
            
        otherwise
            
        % --------------------------------------------------------------------
        %   Enter recurrence calculation :
        %
        %	(n+1) P_{n+1}(x) = (2n+1) x P_{n}(x) - n P_{n-1}(x)
        %
            
        % Recurrence coefficients
            N   = (1:l)                      ;
            Np1 = N + 1                      ;
            A1  = (2 * N + 1) ./ Np1         ;
            A2  = N ./ Np1                   ;
            A3  = 1 ./ (x.^2 - 1)            ;
            
        % Recurrence loop
            for k = 2:l
                Pkp1    = A1(k-1) .* x .* Pk - A2(k-1) .* Pkm1  ;
                DPkp1   = k * A3 .*  (x .* Pkp1 - Pk)            ;
                
                Pkm1    = Pk                                    ;
                Pk      = Pkp1                                  ;
            end
            
            DPl = DPkp1;
    end
    
    
end