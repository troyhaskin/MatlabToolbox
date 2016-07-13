function Space = LogarithmicSpace(Start,End,Length,Base)
    
    if     (nargin < 4)
        Base = 10;
    elseif (nargin > 4)
        error('Too many input arguments passed to LinearSpace')
    end
    
    if     (nargin < 3)
        Length	= 100;
    end
    
    
    
    
    switch (Start ~= End)
        case (true)
            a     = log(Start)/log(Base)                ;
            b     = log(End)/log(Base)                  ;
            Space = Base.^((a: (b-a)/(Length-1) : b).') ;
        case(false)
            Space	= ones(Length,1) * Start            ;
    end

end