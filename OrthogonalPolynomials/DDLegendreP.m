function DDPk = DDLegendreP(x,l)
    
    Pkm1    = 1.0 + 0 * x   ;    % Zeroth order
    Pk      = x             ;    % First  order
    DPk     = 0 * x         ;    % First  order first derivative
    
    
    switch (l)
        case ({0,1})
            DDPk = 0 * x ;
            
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
            A4  = x.^2 + 1                   ;
            A5  = A3.^2                      ;
            
            % Recurrence loop
            for k = 2:l
                Pkp1    = A1(k-1) .* x .* Pk - A2(k-1) .* Pkm1  ;
                DPkp1   = k * A3 .*  (x .* Pkp1 - Pk)            ;
                Term1   = 2 * x .* Pk - A4 .* Pkp1              ;
                Term2   = (x.^2 - 1) .* (x.*DPkp1 - DPk)        ;
                DDPkp1  = k * A5 .* (Term1 + Term2)              ;
                
                DPk     = DPkp1                                 ;
                Pkm1    = Pk                                    ;
                Pk      = Pkp1                                  ;
            end
            
            DDPk = DDPkp1;
    end
    
end