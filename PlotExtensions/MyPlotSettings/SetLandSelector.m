function [] = SetLandSelector(Style)
	set(gcf,'PaperOrientation','landscape','PaperUnits',Style.Paper.Units , ...
		'PaperPosition'   ,Style.Paper.Span);
end