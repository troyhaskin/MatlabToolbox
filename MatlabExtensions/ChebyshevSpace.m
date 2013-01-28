function Space = ChebyshevSpace(Start,End,Length)
    
    if     (nargin < 3)
        Length	= 100;
    elseif (nargin > 3)
        error('Too many input arguments passed to LinearSpace')
    end

    
    switch (Start ~= End)
        case (true)
            Avg     = (Start + End) / 2 ;
            MidDist = (End - Start) / 2 ;
            n       = Length : -1 : 1   ;
            Space	= Avg + MidDist * cos((2*n-1)/(2*Length) * pi);
            
            Space(1)   = Start ;
            Space(end) = End   ;
            
        case(false)
            error('MatlabExtensions:ChebyshevSpace:BadEndPoint',...
                  'The start and end of the interval must be different.');
    end
end