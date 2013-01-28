function Structure = FillStructureStructs(HStr)
	Structure = repmat(struct(''),HStr.Number,1);
	for k = 1:HStr.Number
		Structure(k).Name    = HStr.Name(k,:);
		Structure(k).ID      = HStr.ID(k);
		Structure(k).Geom    = HStr.Geom(k,:);
		Structure(k).SSI     = HStr.SSI(k,:);
		Structure(k).Bottom  = HStr.Bottom(k);
		Structure(k).Orien   = HStr.Orien(k);
		Structure(k).Source  = HStr.Source(k,:);
		Structure(k).Sub.Num = HStr.Sub.Num(k);
		for m = 1:Structure(k).Sub.Num
			Structure(k).Node.Loc  = HStr.Sub.Node.Loc(k,:);
			Structure(k).Node.Temp = HStr.Sub.Node.Temp(k,:);
			Structure(k).Node.Mat  = HStr.Sub.Node.Mat(k,:);
		end
		Structure(k).Left.BC        = HStr.Left.BC(k,:);
		Structure(k).Left.Rad       = HStr.Left.Rad(k,:);
		Structure(k).Left.FlowType  = HStr.Left.FlowType(k,:);
		Structure(k).Left.Dim       = HStr.Left.Dim(k,:);
		Structure(k).Right.BC       = HStr.Right.BC(k,:);
		Structure(k).Right.Rad      = HStr.Right.Rad(k,:);
		Structure(k).Right.FlowType = HStr.Right.FlowType(k,:);
		Structure(k).Right.Dim      = HStr.Right.Dim(k,:);
		Structure(k).FilmTrack      = HStr.FilmTrack(k,:);
	end
end