function Struct = MakeHeatStructure(Structure,Side,Duct,Span)
	
	
	% ---------------------------------------------------------------
	%  Get geometry from control volumes
	%
	[Index,Naughts,Heights] = ShapeToControlVolume(Duct,Span);
	
	% ---------------------------------------------------------------
	%  Heata structure basic info
	%
	Struct.In_fo.Type = 'HeatStructure';
	Struct.Num        = length(Naughts);
	
	% ---------------------------------------------------------------
	%  IDs to be printed
	%
	Struct.IDs      = (Duct.ID * 1E3) + (0:Struct.Num-1)';
	
	% ---------------------------------------------------------------
	%  IDs that go into the Name
	%
	Name.IDs           = PadSpacesWithZeros(num2str((0:Struct.Num-1)'));
	
	% ---------------------------------------------------------------
	%  Heat structure names
	%
	Struct.Name     = cellstr(strcat(Structure.Type,'-HS-',Name.IDs));
	
	% ---------------------------------------------------------------
	%  Heat structure properties
	%
	Struct.Hnaughts    = Naughts								;
	Struct.Heights     = Heights								;
	Struct.Geometry    = Structure.Geom							;
	Struct.SSI         = Structure.SSI							;
	Struct.Source      = Structure.Source						;
	Struct.FilmTrack   = Structure.FilmTrack					;
	Struct.Orientation = AssignOrientationMu(Structure.Orient)	;
	Struct.Nodes       = AssignTemperatures(Structure.Nodes)	;
	
	if (strcmp(Side,'left'))
		Struct.Left     = Structure.Left                                  ;
		Struct.Left.BC  = GetBoundaryCondition(Struct.Left.BC,Duct,Index) ;
		Struct.Right    = Structure.Right                                 ;
	else
		Struct.Right    = Structure.Right                                  ;
		Struct.Right.BC = GetBoundaryCondition(Struct.Right.BC,Duct,Index) ;
		Struct.Left     = Structure.Left                                   ;
	end
	
	Struct.Left.Flow(1)  = {Struct.Left.Flow{1}(1:3) } ;
	Struct.Right.Flow(1) = {Struct.Right.Flow{1}(1:3)} ;
	
	
	%
	%  End of main program
	% ==============================================================================
	
	
	% --------------------------------------------------------- %
	%   Assign the heat structure cosine of inclination         %
	% --------------------------------------------------------- %
	function Mu = AssignOrientationMu(Orientation)
		if    (ischar(Orientation))
			switch(lower(Orientation))
				case('vertical')
					Mu = 1.0;
				case('horizontal')
					Mu = 0.0;
				otherwise
					error('Unrecognized string option for ''Orient'' field.');
			end
		elseif(isscalar(Orientation) && Orientation >= 0 && Orientation <= 1)
			Mu = Orientation;
		else
			error('Unrecognized type for ''Orient'' field.')
		end
	end
	
	
	
	% --------------------------------------------------------- %
	%           Check and notify height vs. span                %
	% --------------------------------------------------------- %
	function [] = CompareHeights(Span,Height)
		
		GEthan(1) = Span(1) < Height.Bot;
		GEthan(2) = Span(2) < Height.Top;
		
		if(GEthan(1))
			fprintf('\n! ============================== !\n' );
			fprintf(  '!             Warning            !\n' );
			fprintf(  '! ============================== !\n' );
			fprintf(  '! Requested struct bottom height !\n' );
			fprintf(  '! could not be exactly matched   !\n' );
			fprintf(  '! to CV height.                  !\n' );
			fprintf(  '! Adjust heights if desired      !\n' );
			fprintf(  '! ============================== !\n' );
			fprintf(  '\tRequested:\t % f\n',Span(1)         );
			fprintf(  '\tAssigned:\t % f\n',Height.Bot       );
		end
		if(GEthan(2))
			fprintf('\n! ============================== !\n' );
			fprintf(  '!             Warning            !\n' );
			fprintf(  '! ============================== !\n' );
			fprintf(  '! Requested struct top height    !\n' );
			fprintf(  '! could not be exactly matched   !\n' );
			fprintf(  '! to CV height.                  !\n' );
			fprintf(  '! Adjust heights if desired      !\n' );
			fprintf(  '! ============================== !\n' );
			fprintf(  '\tRequested:\t % f\n',Span(2)         );
			fprintf(  '\tAssigned:\t % f\n',Height.Top       );
		end
		
	end
	
	
	function [Index,Naughts,Heights] = ShapeToControlVolume(Duct,Span)
		switch(Duct.FlowDir)
			case('Upward')
				
				Index.Bot = find(Span(1) <= Duct.CV.Altitude(:,1),1,'first') ;
				Index.Top = find(Span(2) <= Duct.CV.Altitude(:,2),1,'first') ;
				
				if (isempty(Index.Bot) || isempty(Index.Top))
					error('No matches found.  Improper structure height region')
				end
				
				Height.Bot = Duct.CV.Altitude(Index.Bot,1) ;
				Height.Top = Duct.CV.Altitude(Index.Top,2) ;
				
				CompareHeights(Span,Height);
				
				Naughts = Duct.CV.Altitude(Index.Bot:Index.Top,1)      ;
				Heights = [Naughts(2:end);Height.Top] - Naughts(1:end) ;
				
			case('Downward')
				
				Index.Bot = find(Span(1) <= Duct.CV.Altitude(:,2),1,'last');
				Index.Top = find(Span(2) <= Duct.CV.Altitude(:,1),1,'last');
				
				if (isempty(Index.Bot) || isempty(Index.Top))
					error('No matches found.  Improper structure height region')
				end
				
				Height.Bot = Duct.CV.Altitude(Index.Bot,2) ;
				Height.Top = Duct.CV.Altitude(Index.Top,1) ;
				
				CompareHeights(Span,Height);
				
				Naughts   = Duct.CV.Altitude(Index.Bot:-1:Index.Top,2)   ;
				Heights   = [Naughts(2:end);Height.Top] - Naughts(1:end) ;
				Temp      = Index.Bot                                    ;
				Index.Bot = Index.Top                                    ;
				Index.Top = Temp                                         ;
				
			otherwise
				error('Improper value in ''FlowDir'' field in struct ''Duct''.')
		end
	end
	
	
	% --------------------------------------------------------- %
	%          Generate Temperatures in HS levels               %
	% --------------------------------------------------------- %
	function OutCell = AssignTemperatures(NodalTemps)
		Nrows	= size(NodalTemps,1)		;
		Ncols	= size(NodalTemps,2)		;
		Npags	= Struct.Num				;
		OutCell	= cell(Nrows,Ncols,Npags)	;
		
		Grads	= cell(Nrows,1);
		
		for k = 1:Nrows
			LocalTemps = NodalTemps{k,2};
			if (IsVector(LocalTemps))
				Grads(k) = {LinearSpace(LocalTemps(1),LocalTemps(2),Npags)};
			elseif (isscalar(LocalTemps))
				Grads(k) = {LinearSpace(LocalTemps,LocalTemps,Npags)};
			end
		end
		
		Temps = cell2mat(Grads);
		for k = 1:Npags
			OutCell(:,1,k) = NodalTemps(:,1);
			OutCell(:,3,k) = NodalTemps(:,3);
			OutCell(:,2,k) = num2cell(Temps(:,k))	;
		end
	end
end