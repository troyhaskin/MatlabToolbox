function [] = SetContourSelector(Selector,Style)
	
	 SetAxisSelector(Style);
	switch (Selector)
		case('contour')
			SetColorbar([]      ,Style.Font.ColBar,Style.Size.ColBar,Style.Weight.ColBar)
		case('ylogcontour')
			SetColorbar('YScale',Style.Font.ColBar,Style.Size.ColBar,Style.Weight.ColBar)
		case('xlogcontour')
			SetColorbar('XScale',Style.Font.ColBar,Style.Size.ColBar,Style.Weight.ColBar)
		otherwise
			error('Something went wrong in SetContourSelector switch.')
	end
	
	% Contour Helper Function -------------------------
	function [] = SetColorbar(Label,Font,Size,Weight)
		if (~isempty(Label))
			set(gca,Label,'log')
		end
		% Set the colormap (future option)
		colormap(jet(1000));
		colorbar;
		
		% Set the surface color to interp
		set(get(gca,'Children'),'EdgeColor','interp','FaceColor','interp');
		colorbar('FontName',Font,'FontSize',Size,'FontWeight',Weight);
		
		% Set the colorbar limits
		Lower = GenMin(get(get(gca,'Children'),'ZData'));
		Lower = floor(10*Lower)/10;
		Hgher = GenMax(get(get(gca,'Children'),'ZData'));
		Hgher = ceil(10*Hgher)/10;
		set(gca,'CLim',[Lower,Hgher]);
		
		
		hold('off');
	end
end