function Space = LinearSpace(Start,End,Length)
    
    if     (nargin < 3)
        Length	= 100;
    elseif (nargin > 3)
        error('Too many input arguments passed to LinearSpace')
    end
    
    
    
    
    switch (Start ~= End)
        case (true)
            Space	= Start : (End-Start)/(Length-1) : End	;
        case(false)
            Space	= ones(1,Length) * Start					;
    end
    
end