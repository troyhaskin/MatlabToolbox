function Logical = IsDefined(String,StringSet)
	Logical = sum(strcmpi(String,StringSet)) > 0;
end