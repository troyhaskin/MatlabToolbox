function Level = InputLeveler(NumberOfArgs,FirstArgument)
	
	if     (NumberOfArgs == 1)
		StructCheck(FirstArgument);
		Level = 1;
	elseif (NumberOfArgs == 0 && strcmp(FirstArgument,'axis'))
		Level = 1;
	elseif (NumberOfArgs > 1)
		Level = 2;
	else
		error('No enough input arguments.')
	end
	
end