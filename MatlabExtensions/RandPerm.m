function RP = RandPerm(Integer,Rows,Cols)
	
	if (nargin < 3)
		Cols = 1;
	end
	
	RP = ceil(Integer*rand(Rows,Cols));
end