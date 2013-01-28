function Struct = AppendHeatStructure(Structure,Side,Duct)
	
	switch(Side)
		case('left')
			Information = Structure.BC.Left.BC  ;
			Field       = 'Left';
		case('right')
			Information = Structure.BC.Right.BC ;
			Field       = 'Right';
	end
	
	Indexes = FindLegalVolumes(Structure.Hnaughts,Duct.CV.Altitude,Duct.FlowDir);
	
	if (~iscell(Information))
		Struct.BC.(Field) = Information  ;
		return
	end
	
	switch(lower(Information{1}))
	% ---------------------------------------------------------------
	%   Convective Boundary
	%
		case('convective')
			BoundaryState.In_fo.Type = 'Convective';
			
			if (length(Information) == 1)
				BoundaryState.In_fo.Variant = 'Default';
			else
				BoundaryState.In_fo.Variant = 'Custom';
			end
			
			switch(BoundaryState.In_fo.Variant)
				case('Default')
					BoundaryState.Type = 'CalcCoefHS';
					
					if (length(Duct.CV.Name)~=1)
						BoundaryState.CVs  = Duct.CV.Name(Indexes.Volume);
					else
						BoundaryState.CVs  = Duct.CV.Name;
					end
					
					BoundaryState.Opt1 = 'No';
				case('Custom')
					% Fill in later.
			end
			
			% ---------------------------------------------------------------
	%   Radiative Boundary
	%
		case('radiative')
			
			BoundaryState.In_fo.Type = 'Radiative';
			
			if (length(Information) == 3)
				BoundaryState.In_fo.Variant = 'Default';
			else
				BoundaryState.In_fo.Variant = 'Custom';
			end
			
			switch(BoundaryState.In_fo.Variant)
				case('Default')
					BoundaryState.Type = 'FluxTimeTF'   ;
					BoundaryState.Name = Information{2} ;
					BoundaryState.Val  = Information{3} ;
					BoundaryState.Opt1 = 'No'           ;
					
					WriteTabularFunction(BoundaryState);
					
				case('Custom')
					% Fill in later.
			end
	end
	
	Struct.BC.(Field) = BoundaryState;
	
	
	
	
	
	function Index = FindLegalVolumes(Heights,Altitudes,FlowDir)
		
		HSi= zeros(length(Heights),1);
		CVi= zeros(length(Heights),1);
		counter = 0;
		
		switch(FlowDir)
			case('Upward')
				for k = 1:length(Heights)
					IndexLoc = find(Heights(k) == Altitudes(:,1));
					if(~isempty(IndexLoc))
						counter      = counter + 1 ;
						HSi(counter) = k           ;
						CVi(counter) = IndexLoc    ;
					end
				end
				
			case('Downward')
				for k = 1:length(Heights)
					IndexLoc = find(Heights(k) == Altitudes(:,2));
					if(~isempty(IndexLoc))
						counter      = counter + 1 ;
						HSi(counter) = k           ;
						CVi(counter) = IndexLoc    ;
					end
				end
			otherwise
				error('Improper value in ''FlowDir'' field in struct ''Duct''.')
		end
		
		Index.Struct = HSi(1:counter);
		Index.Volume = CVi(1:counter);
		
	end
end