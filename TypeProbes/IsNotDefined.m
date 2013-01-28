function Logical = IsNotDefined(String,StringSet)
	Logical = sum(strcmpi(String,StringSet)) == 0;
end