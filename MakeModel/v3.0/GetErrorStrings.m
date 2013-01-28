function Error = GetErrorStrings(Script)
	switch(Script)
		case('ControlVolumeInputHandler')
			Error.NotDefined	= 'Control volume %s is undefined.';
			Error.NotStruct		= 'Control volume %s must be a struct';
			Error.NotNumber		= 'Control volume %s must be numeric';
			Error.NotBlah		= 'Control volume %s must be %s';
			Error.TooLong		= 'Control volume %s must be %G letters or less.';
		otherwise
			error('Unsupported script input. Not string set available.')
	end
end