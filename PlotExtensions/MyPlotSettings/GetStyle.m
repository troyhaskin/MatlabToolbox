function Style = GetStyle(MoreSelectors)
	
	StyleMode = 'Default';   % Default Style Mode
	
	if (~isempty(MoreSelectors))
		[StyleMode,StyleLoc] = FindCountStructs(MoreSelectors);
		if (~isempty(StyleLoc))
			UserStyle = ExtractStruct(MoreSelectors,StyleLoc);
		end
	end
	
	switch(StyleMode)
		case('Custom')
			Style          = CustomizeStyle(UserStyle);
			Style.Location = StyleLoc;
		case('Default')
			Style          = GetDefaultStyle();
			Style.Location = [];
		otherwise
			error('Something went wrong in StyleMode switch')
	end
end