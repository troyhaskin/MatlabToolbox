function HStr = HSSetup(CVol)
	Repeats     = CVol.Number;
	HStr.Number = 2*3*Repeats; % 1 up, 1 down, 3 sides per direction
	IDPool      = (0:1:HStr.Number-1)'+1E3;
	
	Temp.Down.Front.ID = IDPool(1:Repeats);
	Temp.Down.Back.ID  = IDPool(1*Repeats+1:2*Repeats);
	Temp.Down.Side.ID  = IDPool(2*Repeats+1:3*Repeats);
	Temp.Up.Front.ID   = IDPool(3*Repeats+1:4*Repeats);
	Temp.Up.Back.ID    = IDPool(4*Repeats+1:5*Repeats);
	Temp.Up.Side.ID    = IDPool(5*Repeats+1:6*Repeats);
	HStr.ID            = Combine(Temp);
	clear('Temp')
	
	Down.Front.IDStr = num2str(IDPool(1:Repeats)-1E3);
	Down.Back.IDStr  = num2str(IDPool(1*Repeats+1:2*Repeats)-1E3);
	Down.Side.IDStr  = num2str(IDPool(2*Repeats+1:3*Repeats)-1E3);
	Up.Front.IDStr   = num2str(IDPool(3*Repeats+1:4*Repeats)-1E3);
	Up.Back.IDStr    = num2str(IDPool(4*Repeats+1:5*Repeats)-1E3);
	Up.Side.IDStr    = num2str(IDPool(5*Repeats+1:6*Repeats)-1E3);
	
	SingleID             = num2str((0:CVol.Number-1)');
	Temp.Down.Front.Name = strcat('HS-',Down.Front.IDStr,'-DownF-',SingleID);
	Temp.Down.Back.Name  = strcat('HS-',Down.Back.IDStr,'-DownB-',SingleID);
	Temp.Down.Side.Name  = strcat('HS-',Down.Side.IDStr,'-DownS-',SingleID);
	Temp.Up.Front.Name   = strcat('HS-',Up.Front.IDStr,'-UpF-',SingleID);
	Temp.Up.Back.Name    = strcat('HS-',Up.Back.IDStr,'-UpB-',SingleID);
	Temp.Up.Side.Name    = strcat('HS-',Up.Side.IDStr,'-UpS-',SingleID);
	Temp.Down.Front.Name = PadSpacesWithZeros(Temp.Down.Front.Name);
	Temp.Down.Back.Name  = PadSpacesWithZeros(Temp.Down.Back.Name);
	Temp.Down.Side.Name  = PadSpacesWithZeros(Temp.Down.Side.Name);
	Temp.Up.Front.Name   = PadSpacesWithZeros(Temp.Up.Front.Name);
	Temp.Up.Back.Name    = PadSpacesWithZeros(Temp.Up.Back.Name);
	Temp.Up.Side.Name    = PadSpacesWithZeros(Temp.Up.Side.Name);
	HStr.Name            = Combine(Temp);
	clear('Temp')
	
	Temp.Down.Front.Orien = 1.0*ones(Repeats,1);
	Temp.Down.Back.Orien  = 1.0*ones(Repeats,1);
	Temp.Down.Side.Orien  = 1.0*ones(Repeats,1);
	Temp.Up.Front.Orien   = 1.0*ones(Repeats,1);
	Temp.Up.Back.Orien    = 1.0*ones(Repeats,1);
	Temp.Up.Side.Orien    = 1.0*ones(Repeats,1);
	HStr.Orien            = Combine(Temp);
	clear('Temp')
	
	Temp.Down.Front.Bottom = CVol.CoarseHeight(2:Repeats+1);
	Temp.Down.Back.Bottom  = CVol.CoarseHeight(2:Repeats+1);
	Temp.Down.Side.Bottom  = CVol.CoarseHeight(2:Repeats+1);
	Temp.Up.Front.Bottom   = CVol.CoarseHeight(Repeats+1:2*Repeats);
	Temp.Up.Back.Bottom    = CVol.CoarseHeight(Repeats+1:2*Repeats);
	Temp.Up.Side.Bottom    = CVol.CoarseHeight(Repeats+1:2*Repeats);
	HStr.Bottom            = Combine(Temp);
	clear('Temp')
	
	Temp.Down.Front.Geom = repmat('Rectangular',Repeats,1);
	Temp.Down.Back.Geom  = repmat('Rectangular',Repeats,1);
	Temp.Down.Side.Geom  = repmat('Rectangular',Repeats,1);
	Temp.Up.Front.Geom   = repmat('Rectangular',Repeats,1);
	Temp.Up.Back.Geom    = repmat('Rectangular',Repeats,1);
	Temp.Up.Side.Geom    = repmat('Rectangular',Repeats,1);
	HStr.Geom            = Combine(Temp);
	clear('Temp')
	
	Temp.Down.Front.SSI = repmat('No',Repeats,1);
	Temp.Down.Back.SSI  = repmat('No',Repeats,1);
	Temp.Down.Side.SSI  = repmat('No',Repeats,1);
	Temp.Up.Front.SSI   = repmat('No',Repeats,1);
	Temp.Up.Back.SSI    = repmat('No',Repeats,1);
	Temp.Up.Side.SSI    = repmat('No',Repeats,1);
	HStr.SSI            = Combine(Temp);
	clear('Temp')
	
	Temp.Down.Front.Source = repmat('No',Repeats,1);
	Temp.Down.Back.Source  = repmat('No',Repeats,1);
	Temp.Down.Side.Source  = repmat('No',Repeats,1);
	Temp.Up.Front.Source   = repmat('No',Repeats,1);
	Temp.Up.Back.Source    = repmat('No',Repeats,1);
	Temp.Up.Side.Source    = repmat('No',Repeats,1);
	HStr.Source            = Combine(Temp);
	clear('Temp')
	
	NodeNumber              = 2.*ones(Repeats,1);
	Temp.Down.Front.Sub.Num = NodeNumber;
	Temp.Down.Back.Sub.Num  = NodeNumber;
	Temp.Down.Side.Sub.Num  = NodeNumber;
	Temp.Up.Front.Sub.Num   = NodeNumber;
	Temp.Up.Back.Sub.Num    = NodeNumber;
	Temp.Up.Side.Sub.Num    = NodeNumber;
	HStr.Sub.Num            = SubCombine(Temp);
	clear('Temp');
	
	Temp.Down.Front.Sub.Node.Temp = 350*ones(Repeats,NodeNumber(1));
	Temp.Down.Back.Sub.Node.Temp  = 350*ones(Repeats,NodeNumber(1));
	Temp.Down.Side.Sub.Node.Temp  = 350*ones(Repeats,NodeNumber(1));
	Temp.Up.Front.Sub.Node.Temp   = 350*ones(Repeats,NodeNumber(1));
	Temp.Up.Back.Sub.Node.Temp    = 350*ones(Repeats,NodeNumber(1));
	Temp.Up.Side.Sub.Node.Temp    = 350*ones(Repeats,NodeNumber(1));
	HStr.Sub.Node.Temp            = NodeCombine(Temp);
	clear('Temp');

	Temp.Down.Front.Sub.Node.Mat = repmat('Stainless-Steel',Repeats,1);
	Temp.Down.Back.Sub.Node.Mat  = repmat('Stainless-Steel',Repeats,1);
	Temp.Down.Side.Sub.Node.Mat  = repmat('Stainless-Steel',Repeats,1);
	Temp.Up.Front.Sub.Node.Mat   = repmat('Stainless-Steel',Repeats,1);
	Temp.Up.Back.Sub.Node.Mat    = repmat('Stainless-Steel',Repeats,1);
	Temp.Up.Side.Sub.Node.Mat    = repmat('Stainless-Steel',Repeats,1);
	HStr.Sub.Node.Mat            = NodeCombine(Temp);
	clear('Temp');
	
	Temp.Down.Front.Sub.Node.Loc = repmat([0,0.0047],Repeats,1);
	Temp.Down.Back.Sub.Node.Loc  = repmat([0,0.0047],Repeats,1);
	Temp.Down.Side.Sub.Node.Loc  = repmat([0,0.0047],Repeats,1);
	Temp.Up.Front.Sub.Node.Loc   = repmat([0,0.0047],Repeats,1);
	Temp.Up.Back.Sub.Node.Loc    = repmat([0,0.0047],Repeats,1);
	Temp.Up.Side.Sub.Node.Loc    = repmat([0,0.0047],Repeats,1);
	HStr.Sub.Node.Loc            = NodeCombine(Temp);
	clear('Temp');
	
	SymmetryBounds          = repmat(GetBCInput('Symmetry'),Repeats,1);
	LastFluxIndex           = 34;
	Temp.Down.Front.Left.BC = SymmetryBounds;
	Temp.Down.Back.Left.BC  = SymmetryBounds;
	Temp.Down.Side.Left.BC  = SymmetryBounds;
	Temp.Up.Front.Left.BC   = GetHotBounds(LastFluxIndex,CVol);
	Temp.Up.Back.Left.BC    = SymmetryBounds;
	Temp.Up.Side.Left.BC    = SymmetryBounds;
	HStr.Left.BC            = LeftCombine(Temp);
	clear('Temp')
	
	Temp.Down.Front.Right.BC = SymmetryBounds;
	Temp.Down.Back.Right.BC  = SymmetryBounds;
	Temp.Down.Side.Right.BC  = SymmetryBounds;
	Temp.Up.Front.Right.BC   = SymmetryBounds;
	Temp.Up.Back.Right.BC    = SymmetryBounds;
	Temp.Up.Side.Right.BC    = SymmetryBounds;
	HStr.Right.BC            = RightCombine(Temp);
	clear('Temp')
	
	RadBounds = GetRadBounds(0.9,'Equiv-Band',0.18,Repeats);
	Temp.Down.Front.Left.Rad  = RadBounds;
	Temp.Down.Back.Left.Rad   = RadBounds;
	Temp.Down.Side.Left.Rad   = RadBounds;
	Temp.Up.Front.Left.Rad    = RadBounds;
	Temp.Up.Back.Left.Rad     = RadBounds;
	Temp.Up.Side.Left.Rad     = RadBounds;
	HStr.Left.Rad             = LeftCombine(Temp);
	clear('Temp')
	
	Temp.Down.Front.Right.Rad = RadBounds;
	Temp.Down.Back.Right.Rad  = RadBounds;
	Temp.Down.Side.Right.Rad  = RadBounds;
	Temp.Up.Front.Right.Rad   = RadBounds;
	Temp.Up.Back.Right.Rad    = RadBounds;
	Temp.Up.Side.Right.Rad    = RadBounds;
	HStr.Right.Rad            = RightCombine(Temp);
	clear('Temp')
	
	
	FlowBounds = GetFlowBounds('Ext',0.9,0.9,Repeats);
	Temp.Down.Front.Left.FlowType  = FlowBounds;
	Temp.Down.Back.Left.FlowType   = FlowBounds;
	Temp.Down.Side.Left.FlowType   = FlowBounds;
	Temp.Up.Front.Left.FlowType    = FlowBounds;
	Temp.Up.Back.Left.FlowType     = FlowBounds;
	Temp.Up.Side.Left.FlowType     = FlowBounds;
	HStr.Left.FlowType             = LeftCombine(Temp);
	clear('Temp')
	
	FlowBounds = GetFlowBounds('Int',0.9,0.9,Repeats);
	Temp.Down.Front.Right.FlowType = FlowBounds;
	Temp.Down.Back.Right.FlowType  = FlowBounds;
	Temp.Down.Side.Right.FlowType  = FlowBounds;
	Temp.Up.Front.Right.FlowType   = FlowBounds;
	Temp.Up.Back.Right.FlowType    = FlowBounds;
	Temp.Up.Side.Right.FlowType    = FlowBounds;
	HStr.Right.FlowType            = RightCombine(Temp);
	clear('Temp')
	
	SurfaceArea = 3.4902588;
	Lchar       = 0.25;
	Height      = 0.25;
	Dim = ones(Repeats,1)*[SurfaceArea,Lchar,Height];
	Temp.Down.Front.Left.Dim  = Dim;
	Temp.Down.Back.Left.Dim   = Dim;
	Temp.Down.Side.Left.Dim   = Dim;
	Temp.Up.Front.Left.Dim    = Dim;
	Temp.Up.Back.Left.Dim     = Dim;
	Temp.Up.Side.Left.Dim     = Dim;
	HStr.Left.Dim             = LeftCombine(Temp);
	clear('Temp')
	
	Temp.Down.Front.Right.Dim = Dim;
	Temp.Down.Back.Right.Dim  = Dim;
	Temp.Down.Side.Right.Dim  = Dim;
	Temp.Up.Front.Right.Dim   = Dim;
	Temp.Up.Back.Right.Dim    = Dim;
	Temp.Up.Side.Right.Dim    = Dim;
	HStr.Right.Dim            = RightCombine(Temp);
	clear('Temp')
	
	Temp.Down.Front.FilmTrack  = repmat('Off',Repeats,1);
	Temp.Down.Back.FilmTrack   = repmat('Off',Repeats,1);
	Temp.Down.Side.FilmTrack   = repmat('Off',Repeats,1);
	Temp.Up.Front.FilmTrack    = repmat('Off',Repeats,1);
	Temp.Up.Back.FilmTrack     = repmat('Off',Repeats,1);
	Temp.Up.Side.FilmTrack     = repmat('Off',Repeats,1);
	HStr.FilmTrack             = Combine(Temp);
	clear('Temp')
	
	function HotBounds = GetHotBounds(Cutoff,CVol)
		Repeats      = CVol.Number;
		BoundVols    = CVol.Names(Repeats+2:Repeats+Cutoff+1,:);
		Flux         = 1:length(Repeats+2:Repeats+35);
		NoFlux       = Flux(end)+1:Repeats;
		NumNoFlux    = length(NoFlux);
		FluxBounds   = GetBCInput('FluxTimeTF','HotFluxIn',BoundVols,'No');
		NoFluxBounds = repmat(GetBCInput('Symmetry'),NumNoFlux,1);
		HotBounds    = char(FluxBounds,NoFluxBounds);
	end
	
	function RadBounds = GetRadBounds(Emiss,RadModel,RadLen,Repeats)
		BaseString = [num2str(Emiss),'\t',RadModel,'\t',num2str(RadLen)];
		RadBounds  = repmat(BaseString,Repeats,1);
	end
	
	function FlowBounds = GetFlowBounds(Type,CritPool,CritAtm,Repeats)
		BaseString = [Type,'\t',num2str(CritPool),'\t',num2str(CritAtm)];
		FlowBounds  = repmat(BaseString,Repeats,1);
	end
	
	function CombinedStruct = Combine(Struct)
		Field       = char(fieldnames(Struct.Down.Front));
		CombineType = Struct.Down.Front.(Field);
		
		switch(isnumeric(CombineType))
			case(1)
				CombinedStruct = vertcat(Struct.Down.Front.(Field),...
					Struct.Down.Back.(Field)                      ,...
					Struct.Down.Side.(Field)                      ,...
					Struct.Up.Front.(Field)                       ,...
					Struct.Up.Back.(Field)                        ,...
					Struct.Up.Side.(Field));
			case(0)
				CombinedStruct = char(Struct.Down.Front.(Field)   ,...
					Struct.Down.Back.(Field)                      ,...
					Struct.Down.Side.(Field)                      ,...
					Struct.Up.Front.(Field)                       ,...
					Struct.Up.Back.(Field)                        ,...
					Struct.Up.Side.(Field));
			otherwise
				error('Unrecognized type passed to Combine in HSSetup.')
		end
		
		
	end
	function CombinedStruct = LeftCombine(Struct)
		Field       = char(fieldnames(Struct.Down.Front.Left));
		CombineType = Struct.Down.Front.Left.(Field);
		switch(isnumeric(CombineType))
			case(1)
				CombinedStruct = vertcat(Struct.Down.Front.Left.(Field),...
					Struct.Down.Back.Left.(Field)                      ,...
					Struct.Down.Side.Left.(Field)                      ,...
					Struct.Up.Front.Left.(Field)                       ,...
					Struct.Up.Back.Left.(Field)                        ,...
					Struct.Up.Side.Left.(Field));
			case(0)
				CombinedStruct = char(Struct.Down.Front.Left.(Field)   ,...
					Struct.Down.Back.Left.(Field)                      ,...
					Struct.Down.Side.Left.(Field)                      ,...
					Struct.Up.Front.Left.(Field)                       ,...
					Struct.Up.Back.Left.(Field)                        ,...
					Struct.Up.Side.Left.(Field));
			otherwise
				error('Unrecognized type passed to Combine in HSSetup.')
		end
	end
	
	
	function CombinedStruct = RightCombine(Struct)
		Field       = char(fieldnames(Struct.Down.Front.Right));
		CombineType = Struct.Down.Front.Right.(Field);
		switch(isnumeric(CombineType))
			case(1)
				CombinedStruct = vertcat(Struct.Down.Front.Right.(Field),...
					Struct.Down.Back.Right.(Field)                      ,...
					Struct.Down.Side.Right.(Field)                      ,...
					Struct.Up.Front.Right.(Field)                       ,...
					Struct.Up.Back.Right.(Field)                        ,...
					Struct.Up.Side.Right.(Field));
			case(0)
				CombinedStruct = char(Struct.Down.Front.Right.(Field)   ,...
					Struct.Down.Back.Right.(Field)                      ,...
					Struct.Down.Side.Right.(Field)                      ,...
					Struct.Up.Front.Right.(Field)                       ,...
					Struct.Up.Back.Right.(Field)                        ,...
					Struct.Up.Side.Right.(Field));
			otherwise
				error('Unrecognized type passed to Combine in HSSetup.')
		end
	end
	
	
	function CombinedStruct = SubCombine(Struct)
		Field       = char(fieldnames(Struct.Down.Front.Sub));
		CombineType = Struct.Down.Front.Sub.(Field);
		switch(isnumeric(CombineType))
			case(1)
				CombinedStruct = vertcat(Struct.Down.Front.Sub.(Field),...
					Struct.Down.Back.Sub.(Field)                      ,...
					Struct.Down.Side.Sub.(Field)                      ,...
					Struct.Up.Front.Sub.(Field)                       ,...
					Struct.Up.Back.Sub.(Field)                        ,...
					Struct.Up.Side.Sub.(Field));
			case(0)
				CombinedStruct = char(Struct.Down.Front.Sub.(Field)   ,...
					Struct.Down.Back.Sub.(Field)                      ,...
					Struct.Down.Side.Sub.(Field)                      ,...
					Struct.Up.Front.Sub.(Field)                       ,...
					Struct.Up.Back.Sub.(Field)                        ,...
					Struct.Up.Side.Sub.(Field));
			otherwise
				error('Unrecognized type passed to Combine in HSSetup.')
		end
	end
	
		function CombinedStruct = NodeCombine(Struct)
		Field       = char(fieldnames(Struct.Down.Front.Sub.Node));
		CombineType = Struct.Down.Front.Sub.Node.(Field);
		switch(isnumeric(CombineType))
			case(1)
				CombinedStruct = vertcat(Struct.Down.Front.Sub.Node.(Field),...
					Struct.Down.Back.Sub.Node.(Field)                      ,...
					Struct.Down.Side.Sub.Node.(Field)                      ,...
					Struct.Up.Front.Sub.Node.(Field)                       ,...
					Struct.Up.Back.Sub.Node.(Field)                        ,...
					Struct.Up.Side.Sub.Node.(Field));
			case(0)
				CombinedStruct = char(Struct.Down.Front.Sub.Node.(Field)   ,...
					Struct.Down.Back.Sub.Node.(Field)                      ,...
					Struct.Down.Side.Sub.Node.(Field)                      ,...
					Struct.Up.Front.Sub.Node.(Field)                       ,...
					Struct.Up.Back.Sub.Node.(Field)                        ,...
					Struct.Up.Side.Sub.Node.(Field));
			otherwise
				error('Unrecognized type passed to Combine in HSSetup.')
		end
	end
end