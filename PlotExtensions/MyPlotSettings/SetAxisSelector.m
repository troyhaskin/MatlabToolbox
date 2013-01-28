function [] = SetAxisSelector(Style)
	set(gca,'Box','on')
	EnforceAxisLimits();
	grid('on');
	SetAxis('XLabel',Style.Font.Label.x,Style.Size.Label.x,Style.Weight.Label.x );
	SetAxis('YLabel',Style.Font.Label.y,Style.Size.Label.y,Style.Weight.Label.y );
	SetAxis('Title' ,Style.Font.Title  ,Style.Size.Title  ,Style.Weight.Title   );
	SetAxis([]      ,Style.Font.Axis   ,Style.Size.Axis   ,Style.Weight.Axis    );
	
	% Axis Helper Function ----------------------------
	function [] = SetAxis(Label,Font,Size,Weight)
		if (~isempty(Label))
			set(get(gca,Label),'FontName',Font,'FontSize',Size,'FontWeight',Weight);
		else
			set(gca,'FontName',Font,'FontSize',Size,'FontWeight',Weight);
		end
	end
	
	function [] = EnforceAxisLimits()
		xData = get(get(gca,'Children'),'XData');
		yData = get(get(gca,'Children'),'YData');
		xLow  = GenMin(xData);
		xHi   = GenMax(xData);
		yLow  = GenMin(yData);
		yHi   = GenMax(yData);
		axis([0.99999*xLow,1.000001*xHi,yLow,yHi]);
	end
end