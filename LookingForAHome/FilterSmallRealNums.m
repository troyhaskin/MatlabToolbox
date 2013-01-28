function Filtered = FilterSmallRealNums(Numbers,Tolerance)
    
    error(nargchk(1,2,nargin));
    
    if (nargin < 2)
        Tolerance = eps();
    end
    
    Valid       = abs(Numbers) > Tolerance  ;
    Filtered	= Valid .* Numbers          ;
end