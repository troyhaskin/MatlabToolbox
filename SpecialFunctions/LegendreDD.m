function DDPn = LegendreDD(x,N)
    
    Pkm2 = 1.0 + 0 * x   ;    % Zeroth order
    Pkm1 = x             ;    % First  order
    
    
    switch (N)
        case ({0,1})
            DDPn = 0 * x ;
            
        otherwise
            
            % --------------------------------------------------------------------
            %   Enter recurrence calculation :
            %
            %	(n+1) P_{n+1}(x) = (2n+1) x P_{n}(x) - n P_{n-1}(x)
            %
            
            % Recurrence coefficients
            n     = (2:N);
            a1    = (2*n - 1) ./ n      ;
            a2    =  (1 - n)  ./ n      ;
            
            Pn   = Pkm1;
            Pkm1 = Pkm2;
            
            % Recurrence loop
            for k = n-1
                
                % Update
                Pkm2 = Pkm1 ;
                Pkm1 = Pn   ;
                
                % n-th Legendre polynomial
                Pn = a1(k) .* x .* Pkm1 + a2(k) .* Pkm2;

            end
            
            % Second derivative
            DDPn = N*(x.^2*(N-1)-1) .* Pn + (3 -2*N)*N*x .* Pkm1 + N*(N-1) * Pkm2;
            DDPn = DDPn ./ (x.^2 - 1).^2;
    end
    
end