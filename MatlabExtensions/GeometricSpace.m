function Space = GeometricSpace(Start,End,Stretch,Length)
    
    if     (nargin == 2)
        Stretch	= 1.1															;
        Length	= 100															;
    elseif (nargin == 3)
        Length	= 100															;
    elseif (nargin >= 5)
        error('MyMatlabToolbox:GeometricSpace:TooManyArguments',...
              'Too many input arguments passed to GeometricSpace')				;
    elseif (nargin < 2)
        error('MyMatlabToolbox:GeometricSpace:TooFewArguments',...
              'Too few input arguments passed to GeometricSpace')				;
    end
    
    
    
    if (Stretch == 1)
        Space = LinearSpace(Start,End,Length)'									;
    else
        Scale	= (Stretch - 1)/(Stretch^(Length-1)-1) .* (End-Start)           ;
        K		= [0;CumulativeGeometricSeries(Scale,Stretch,Length-1)]         ;
        Space	= Start + K                                                     ;
    end

end