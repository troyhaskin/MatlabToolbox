function Filtered = FilterSmallComplexNums(Numbers,RealTolerance,ImagTolerance)
    
    error(nargchk(1,3,nargin));
    
    switch(nargin)
        case(1)
            RealTolerance = eps();
            ImagTolerance = eps();
        case(2)
            ImagTolerance = RealTolerance;
    end
    
    ValidReal	= abs(real(Numbers)) > RealTolerance                            ;
    ValidImag	= abs(imag(Numbers)) > ImagTolerance                            ;
    Filtered    = ValidReal .* real(Numbers) + ValidImag .* imag(Numbers) * 1i	;
end