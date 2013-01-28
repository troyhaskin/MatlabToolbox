function [] = StructCheck(FirstArgument)
	if (isstruct(FirstArgument))
		error('Customization Struct given without Selector.');
	end
end