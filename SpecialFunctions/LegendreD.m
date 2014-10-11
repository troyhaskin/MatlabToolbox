function DPn = LegendreD(x,n)
    
    Pkm2 = 1.0 + 0 * x   ;    % Zeroth order
    Pkm1 = x             ;    % First  order
    
    
    switch (n)
        case (0)
            DPn = 0 * x ;
            
        case(1)
            DPn = Pkm2  ;
            
        otherwise
            
        % --------------------------------------------------------------------
        %   Enter recurrence calculation :
        %
        %	k P_k = (2k - 1) x P_{k-1} - (k-1) P_{k-2}
        %   DPk   = k/(x^2-1) * ( x P_k - P_{k-1} )
        %               :
        %               :
        %   DPk = 1/(x^2 - 1) (  ( (2k-1)x^2 - k ) P_{k-1) + (1-k) x P_{k-2}  )
        %
            
            % Recurrence coefficients
            n     = (2:n)           ;
            a1    = (2*n - 1) ./ n  ;
            a2    =  (1 - n)  ./ n  ;
            
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
            % Derivative
            DPn = (k+1) * (x .* Pn - Pkm1) ./ (x.^2 - 1);
    end
    
    
end