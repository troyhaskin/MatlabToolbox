function [] = Plotxx(x1,y1,x2,y2,varargin)
	
	
	line(x1,y1,'Color','k');
	
	Axis(1) = gca;
	set(Axis(1),'XColor','k','YColor','k')
	MyPlotSettings();
	
	Axis(2) = axes('Position',get(Axis(1),'Position'),...
		       'XAxisLocation','top',...
               'YAxisLocation','right',...
               'Color','none',...
               'XColor','k','YColor','k','YTick',[]);
	
	line(x2,y2,'Color','k','Parent',Axis(2));
	MyPlotSettings();
	
end