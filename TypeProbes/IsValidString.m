function Logical = IsValidString(String,Length)
	
	error(nargchk(1,2,nargin));
	
	if (ischar(String) || iscellstr(String))
		Logical = 1;
	else
		Logical = 0;
	end
	
	
	if (nargin > 1)
		if (length(String) > Length)
			Logical = 0;
		end
	end
		
end