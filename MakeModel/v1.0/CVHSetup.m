function CVol = CVHSetup(FlowArea,CVolHeight,TotalHeight)
	CVol.Number       = TotalHeight/CVolHeight;
	CVol.CoarseHeight = ([TotalHeight:-CVolHeight:CVolHeight,0.0,CVolHeight:CVolHeight:TotalHeight])';
	CVol.FineDivs     = 5;
	CVol.IDs          = (0:1:(2*CVol.Number))'+1000;
	
	ColdMask   = 1:CVol.Number;
	HotMask    = CVol.Number+2:length(CVol.IDs);
	SingSideID = (0:1:CVol.Number-1)';
	ColdNames  = strcat('RCCS-',num2str(CVol.IDs(ColdMask)-1000),'-Cld-',num2str(SingSideID));
	HotNames   = strcat('RCCS-',num2str(CVol.IDs(HotMask)-1000),'-Hot-',num2str(SingSideID));
	ColdNames  = PadSpacesWithZeros(ColdNames);
	HotNames   = PadSpacesWithZeros(HotNames);
	BottomName = ['RCCS-',num2str(CVol.IDs(CVol.Number+1)-1000),'-Bottom'];
	
	CVol.Names     = strvcat(ColdNames,BottomName,HotNames); %#ok<VCAT>
	CVol.Temps     = repmat(300.00,size(CVol.Names,1),1);
	CVol.Press     = repmat(101325.00,size(CVol.Names,1),1);
	CVol.Types     = repmat('Pipe',size(CVol.Names,1),1);
	CVol.RelHeight = repmat(CVolHeight,size(CVol.Names,1),1);
	CVol.RelHeight(CVol.Number+1) = 0.1524;
	CVol.FineVolume   = FlowArea.*CVol.RelHeight;
	
	CVol.NCG.N2 = 0.8;
	CVol.NCG.O2 = 0.2;
end