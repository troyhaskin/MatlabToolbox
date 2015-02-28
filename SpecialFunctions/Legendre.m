function [Pn,varargout] = Legendre(x,N)
    
    Pkm2 = 1 + 0 * x;    % Zeroth order
    Pkm1 = x        ;    % First  order
    
    
    switch (N)
        case (0)
            Pn = Pkm2;
            
            if (nargout > 1)
                varargout{1} = Pn;
            end
            if (nargout > 2)
                varargout{2} = Pn;
            end
            
        case (1)
            Pn = Pkm1;
            
            if (nargout > 1)
                varargout{1} = Pkm2;
            end
            if (nargout > 2)
                varargout{2} = Pkm2;
            end
            
        otherwise
            
            % --------------------------------------------------------------------
            %   Enter recurrence calculation :
            %
            %	k P_n = (2k - 1) x P_{k-1} - (k-1) P_{k-2}
            %
            
            % Recurrence coefficients
            n  = (2:N);
            a1 = (2*n - 1) ./ n ;
            a2 =  (1 - n)  ./ n ;
            
            % Recurrence loop
            for k = 1:(N-2)
                Pn = a1(k) .* x .* Pkm1 + a2(k) .* Pkm2;
                Pkm2 = Pkm1;
                Pkm1 = Pn;
            end
            Pn = a1(N-1) .* x .* Pkm1 + a2(N-1) .* Pkm2;
            
            if (nargout > 1)
                DPn     = (x.*Pn - Pkm1)./(x.^2-1)*N;
                isUnity = abs(x) == 1;
                DPn(isUnity) = x(isUnity).^(N+1) * N*(N+1)/2;
                varargout{1} = DPn;
            end
            if (nargout > 2)
                % Derivative of N-1 polynomial
                DPnm1          = (x.*Pkm1 - Pkm2)./(x.^2-1)*(N-1);
                DPnm1(isUnity) = x(isUnity).^(N) * (N-1)*(N)/2;
                
                %   Second derivative
                DDPn = ((1-2/N)*x.*DPn - DPnm1 + Pn)./(x.^2-1)*N;
                DDPn(isUnity) = x(isUnity).*DPn(isUnity)*(N-1)*(N+2)/4;
                varargout{2} = DDPn;
            end
    end
    
    
    
    
end