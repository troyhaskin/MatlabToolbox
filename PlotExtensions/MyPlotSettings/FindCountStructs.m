function [StyleMode,StyleLoc] = FindCountStructs(MoreSelectors)
	
	count = 0;
	
	for k = 1:length(MoreSelectors)
		if (~iscellstr(MoreSelectors(k)))
			count     = count + 1;
			StyleLoc  = k;
			StyleMode = 'Custom';
		end
	end
	
	if    (count > 1)
		error('Only one Style Struct is allowed.')
	elseif(count == 0)
		StyleLoc = [];
		StyleMode = 'Default';
	end
end