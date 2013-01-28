function Logical = IsInteger(Number,SignSensitive)
	
    if (nargin < 2)
        Logical = IsIntegral(Number);
    else
        Logical = IsIntegral(Number,SignSensitive);
    end
	 
end