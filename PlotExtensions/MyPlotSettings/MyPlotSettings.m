function [] = MyPlotSettings(Selector,varargin)
	hold('on');
	if ((nargin == 0) || (isempty(Selector)))
		Selector = 'axis';                       % Default Selector
	end
	
	Level = InputLeveler(nargin,Selector);       % Determine the run Level
	Style = GetStyle(varargin);                  % Load plot style
	
	%  Impose selected options  =============================
	switch (Level)
		case(1)
			SetOptions(Selector,Style);
		case(2)
			[Selector,Style] = ExpandSelector(Selector,Style,varargin);
			SetOptions(Selector,Style);
		otherwise
			error('Something went wrong in Level switch')
	end
	hold('off');
end