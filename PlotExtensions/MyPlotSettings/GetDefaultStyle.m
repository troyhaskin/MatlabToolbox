function Style = GetDefaultStyle()

	MajorFont   = 'Times New Roman';
	MajorColor  = GetColor('black');
	MajorWeight = 'normal';
	MajorSize   = 18;
	MidSize     = 18;
	MinorSize   = 14;
	PaperUnits  = 'normalized';
	PaperMode   = 'manual';
	PaperVector = [0.0,0.0,1.0,1.0];

	Style.Font.Label.x   = MajorFont;
	Style.Font.Label.y   = MajorFont;
	Style.Font.Label.z   = MajorFont;
	Style.Font.Title     = MajorFont;
	Style.Font.Axis      = MajorFont;
	Style.Font.ColBar    = MajorFont;
	Style.Size.Label.x   = MidSize;
	Style.Size.Label.y   = MidSize;
	Style.Size.Label.z   = MidSize;
	Style.Size.Title     = MajorSize;
	Style.Size.Axis      = MinorSize;
	Style.Size.ColBar    = MajorSize;
	Style.Color.Label.x  = MajorColor;
	Style.Color.Label.y  = MajorColor;
	Style.Color.Label.z  = MajorColor;
	Style.Color.Title    = MajorColor;
	Style.Color.Axis     = MajorColor;
	Style.Color.ColBar   = MajorColor;
	Style.Weight.Label.x = MajorWeight;
	Style.Weight.Label.y = MajorWeight;
	Style.Weight.Label.z = MajorWeight;
	Style.Weight.Title   = MajorWeight;
	Style.Weight.Axis    = MajorWeight;
	Style.Weight.ColBar  = MajorWeight;
	Style.Paper.Units    = PaperUnits;
	Style.Paper.Span     = PaperVector;
	Style.Paper.Mode     = PaperMode;
end

