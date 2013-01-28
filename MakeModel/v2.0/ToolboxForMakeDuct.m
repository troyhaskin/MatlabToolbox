function Tools = ToolboxForMakeDuct()
	
	Tools.GetID        = @GetDuctID              ;
	Tools.ParseVarArgs = @ParseOptionalArguments ;
	Tools.FillDefaults = @GetDefaultDuctValues   ;
	Tools.GetFlowDir   = @GetFlowDirection       ;
	
	
%{
===============================================================================
	                           SUB-FUNCTIONS
===============================================================================
%}
	
% ---------------------------------------------------------------------- %
%                      Get Control Volume IDs                            %
% ---------------------------------------------------------------------- %
	function Duct = GetDuctID(Duct)
		FileID = fopen('IDscratch','r');
		
		if (FileID == -1)
			
			FileID  = fopen('IDscratch','w') ;
			Duct.ID = 1                      ;
			
		else
			
			Duct.ID = fscanf(FileID,'%d')   ;
			fclose(FileID)                  ;
			FileID = fopen('IDscratch','w') ;
			
		end
		
		fprintf(FileID,'%G',Duct.ID+1)  ;
		fclose(FileID)                  ;
		
	end
% ---------------------------------------------------------------------- %
	
	
	
% ---------------------------------------------------------------------- %
%                      Get Default Duct values                           %
% ---------------------------------------------------------------------- %
	function Duct = GetDefaultDuctValues(Duct)
		Duct.Orient = 'Vertical';
	end
% ---------------------------------------------------------------------- %
	
	
	
% ---------------------------------------------------------------------- %
%                      Get Flow direction                                %
% ---------------------------------------------------------------------- %
	function Duct = GetFlowDirection(Duct)
		deltaH = Duct.deltaH;
		Orient = Duct.Orient;
		if     ((deltaH == 0) && strcmp(Orient,'Vertical'))
			error('Vertical Control Volume height of 0 passed to MakeDuct.')
		elseif ((deltaH ~= 0) && strcmp(Orient,'Horizontal'))
			error('Nonzero Horizontal Control Volume height passed to MakeDuct.')
		elseif ((deltaH == 0) && strcmp(Orient,'Horizontal'))
			Duct.FlowDir = 'Horizontal';
		elseif (deltaH > 0)
			Duct.FlowDir = 'Upward';
		elseif (deltaH < 0)
			Duct.FlowDir = 'Downward';
		end
	end
% ---------------------------------------------------------------------- %
	
	
	
% ---------------------------------------------------------------------- %
%           Parses the Optional Arguments passed to MakeDuct             %
% ---------------------------------------------------------------------- %
	function Pipe = ParseOptionalArguments(Options,Pipe)
		
		NargsPassed = length(Options)           ;
		NargsEven   = (mod(NargsPassed,2) == 0) ;
		ArgsPassed  = (NargsPassed ~= 0)        ;
		
		if (ArgsPassed)
			EmptyArgs   = (isempty(Options{1})) ;
		else
			EmptyArgs = 0;
		end
		
	% ---------------------------------------------------------------
	% Look for option pairs and error if unpaired or return is no pairs
	%
		if ( ~NargsEven && ArgsPassed && ~EmptyArgs)
			error('Uneven number of options passed to MakeDuct')
		elseif(~ArgsPassed || EmptyArgs)
			return
		end
	% --------------------------------------------------------------------
	
		
	% --------------------------------------------------------------------
	% Loop through pairs and assign values
	%
		for k = 1:2:length(Options)
			
			switch(Options{k})
				case('Orientation')
					Pipe.Orient = Options{k+1};
				otherwise
					error('Unknown option ''%s'' passed to MakeDuct',Options{k})
			end
			
		end
	% --------------------------------------------------------------------	
		
	end
% ---------------------------------------------------------------------- %
end