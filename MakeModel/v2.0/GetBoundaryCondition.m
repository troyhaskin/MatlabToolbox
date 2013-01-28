% --------------------------------------------------------- %
%   Assign the heat structure boundary conditions           %
% --------------------------------------------------------- %
function BoundaryState = GetBoundaryCondition(Information,Duct,Index)
	
	if (~iscell(Information))
		BoundaryState.In_fo.Type	= 'Symmetry';
		BoundaryState.Type			= 'Symmetry';
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
					BoundaryState.CVs  = Duct.CV.Name(Index.Bot:Index.Top);
					BoundaryState.Opt1 = 'No';
				case('Custom')
					% Fill in later.
			end
			
	% ---------------------------------------------------------------
	%   Radiative Boundary
	%
		case('radiative')
			
			BoundaryState.In_fo.Type = 'Radiative';
			
			if (length(Information) == 1)
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
			

	% ---------------------------------------------------------------
	%   Surface Boundary
	%
		case('surfacesource')
			
		otherwise
			error('Unrecognized boundary condition passed to Attach.m')
	end
end