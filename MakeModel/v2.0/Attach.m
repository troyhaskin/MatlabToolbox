% ---------------------------------------------------------------------- %
%                     Attach Heat Structure to Duct                      %
% ---------------------------------------------------------------------- %
function Structure = Attach(Structure,Side,varargin)
	
	% ---------------------------------------------------------------
	%  Number of variable arguments passed
	%
	Nvararg = length(varargin);
	
	
	% ---------------------------------------------------------------
	%  Error checking
	%
	CoverAll = ParseInputs(Nvararg,varargin);
	
	
	% ---------------------------------------------------------------
	%  Assign processed arguments
	%
	switch(CoverAll)
		case('no')
			switch(lower(varargin{1}))
				case('to')
					Duct = varargin{2};
					Span = varargin{4};
				case('over')
					Duct = varargin{4};
					Span = varargin{2};
			end
			
		case('yes')
			if (~ischar(varargin{1}))
				Duct = varargin{1};
			else
				Duct = varargin{2};
			end
			Span(1) = min(min(Duct.CV.Altitude));
			Span(2) = max(max(Duct.CV.Altitude));
	end
	
	if (isfield(Structure,'In_fo'))
		Structure = AppendHeatStructure(Structure,lower(Side),Duct);
	else
		Structure = MakeHeatStructure(Structure,lower(Side),Duct,Span);
	end
	
	%
	%	End of main program
	% ---------------------------------------------------------------------- %
	
	
	% ---------------------------------------------------------------------- %
	%                     Input error checking                               %
	% ---------------------------------------------------------------------- %
	function CoverAll = ParseInputs(Nargs,PassedArgs)
		
		error(nargchk(3, 6, Nargs+2));
		
		% ---------------------------------------------------------------
		%   Look for pairs or single input
		%
		if ((mod(Nargs,2) ~= 0) && (Nargs ~= 1))
			error('A full set of pairs was not passed to Attach.m');
		end
		
		% ---------------------------------------------------------------
		%  Make sure there is a struct for the Structure to be attached
		%
		if (Nargs == 1 && ~isstruct(PassedArgs{1}))
			error('No control volume struct passed to Attach.m ');
			
			% ---------------------------------------------------------------
			%  For single passed arugment, make sure it is a struct
			%
		elseif (Nargs == 1 && isstruct(PassedArgs{1}))
			
			if (~strcmp(PassedArgs{1}.In_fo.Type,'Duct'))
				error('No control volume struct passed to Attach.m ');
			end
			
			CoverAll = 'yes';
			
			% ---------------------------------------------------------------
			%  If a single pair is passed, make sure there is a string and
			%     struct
			%
		elseif (Nargs == 2 && isstruct(PassedArgs{2})   ...
				&& ischar(PassedArgs{1}))
			
			if (~strcmp(PassedArgs{2}.In_fo.Type,'Duct'))
				error('No control volume struct passed to Attach.m ');
			end
			
			CoverAll = 'yes';
			
			% ---------------------------------------------------------------
			%  If two pairs are passed, do not attach over whole structure
			%
		else
			CoverAll = 'no';
		end
		
		
		
		if (Nargs == 4)
			switch(lower(varargin{1}))
				case('to')
					if (~isstruct(varargin{2}))
						error('Argument ''to'' passed with non-struct to Attach.m')
					end
					if (~isvector(varargin{4}))
						error('Argument ''over'' passed with non-vector to Attach.m')
					end
					if (~strcmp(varargin{3},'over'))
						error('Argument ''to'' passed without ''over''.')
					end
				case('over')
					if (~isstruct(varargin{4}))
						error('Argument ''to'' passed with non-struct to Attach.m')
					end
					if (~isvector(varargin{2}))
						error('Argument ''over'' passed with non-vector to Attach.m')
					end
					if (~strcmp(varargin{3},'to'))
						error('Argument ''over'' passed without ''to''.')
					end
				otherwise
					error('Improper variable set passed to Attach.m')
			end
			
			CoverAll = 'no';
		end
		
		
		
	end
	% ---------------------------------------------------------------------- %
end
% ---------------------------------------------------------------------- %