function [Selector,Style] = ExpandSelector(OldSelector,OldStyle,UserOptions)
	NotStyle        = setdiff(1:size(UserOptions,2),OldStyle.Location);
	Selector        = UserOptions(NotStyle);
	Selector(end+1) = cellstr(OldSelector);
	Style           = rmfield(OldStyle,'Location');
end