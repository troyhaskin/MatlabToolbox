function Integral = SimpsonsRuleCV(Function,Values)
%   SimpsonsRuleCV
%       Compute Simpson's Rule for the function handle Function given the 
%       interval vector Values.  
%
%       An interval's intergal approximation is
% 
%           I_m = (x_r - x_l)/6 * [f(x_l) + 4 * f(x_m) + f(x_r)],
% 
%       where x_l is all components of Values except last, x_r is all components
%       of Values except the first, and x_m = (x_r + x_l)/2.
%
%       Integral = Sum(I_m) over all m.
%

    % Get the left, middle, and right points to evaluate the function
        LeftValue   = Values(1 : end-1)             ;
        RightValue  = Values(2 :  end )             ;
        MiddleValue	= (LeftValue + RightValue)/2    ;

    % Get the weights of the associated point sets
        Delta           = RightValue - LeftValue    ;
        LeftWeight      = 1/6 * Delta               ;
        RightWeight     = 1/6 * Delta               ;
        MiddleWeight    = 2/3 * Delta               ;

    % Calculate the integral for each interval
        IntegralParts   = LeftWeight   .* Function(  LeftValue  )   + ...
                          MiddleWeight .* Function( MiddleValue )   + ... 
                          RightWeight  .* Function(  RightValue )   ;

    % Sum interval contributions for non-NaN components (Infs are included)
        IntegralParts   = IntegralParts(~isnan(IntegralParts))      ;
        Integral        = sum(IntegralParts)                        ;
	
end