function Roots = RootFindDK(Fun,Nroots)
% Function Name:
%	RootFindDK
% 
% Toolbox:       
%	Matlab Extensions
% 
% Purpose:       
%   Calculate the distinct, complex roots of a single-valued polynomial using
%   the Durand–Kerner method.
%    
% Uses:
% 
%	Roots = RootFindDK(Fun,Nroots);
%       % Returns a vector %Nroots% long containing the roots of the polynomial 
%         function handle %Fun%.
%
% See also
%   fzero roots residue

    
% ------------------------------------------------------------------------------
%   Parse inputs
%
    InputCheck = inputParser()                                                  ;
    InputCheck.addRequired('Fun'   , @IsFunctionHandle     )                    ;
    InputCheck.addRequired('Nroots', @(x) IsIntegral(x,'+'))                    ;
    InputCheck.parse(Fun,Nroots)                                                ;
    
% ------------------------------------------------------------------------------
%   Setup iteration
%    
    Roots               = rand(1,Nroots) ;%+ rand(1,Nroots) * 1i    ; % Complex guesses
    Err                 = ones(1,Nroots)                          ; % Error vector 
    Map                 = @(x,r) x - r                            ; % Contraction map
    Tolerance           = 1.0E-12                                 ; % Error tolerance
    Iter                = 0                                       ; % Iteration counter
    IterMax             = 1E6                                     ; % Ieration max.
    NotConverged        = 1                                       ; % Set to enter loop
    NotPassedIterMax    = 1                                       ; % Set to enter loop

% ------------------------------------------------------------------------------
%   Iteratre on function
%
    while (NotConverged && NotPassedIterMax)
        for k = 1 : Nroots
            Root     = Roots(k)                                         ; % Current root
            Mask     = Roots ~= Root                                    ; % Prevent div. by 0
            Roots(k) = Root - Fun(Root) / prod(Map(Root,Roots(Mask)))	; % Contract
            Err(k)   = Roots(k) - Root                                  ; % Calculate error
        end
        Iter                = Iter + 1                                  ; % Update counter
        NotConverged        = max(abs(Err)) > Tolerance                 ; % Converged?
        NotPassedIterMax    = Iter < IterMax                            ; % Too many iterations?
    end

% ------------------------------------------------------------------------------
%   Complex Clean-up
%
    YesReal = abs(real(Roots)) > Tolerance                                      ;
    YesImag = abs(imag(Roots)) > Tolerance                                      ;
    Roots   = real(Roots) .* YesReal + imag(Roots) .* YesImag * 1i              ;
    Roots   = sort(Roots)                                                       ;
    
% ------------------------------------------------------------------------------
%   Output
%
    if (Iter == IterMax)
        warning('MyToolbox:RootFindDK:NotConvergedToTolerance'                  ,...
            'Solution did not converge below max. tolerance in %G iterations'   ,...
            IterMax                                                             );
    end
    
end