function CVInfo = ControlVolumeInputHandler(CVstruct)
	
	Error = GetErrorStrings('ControlVolumeInputHandler');
	
% ------------------------------------------------------------------------------
%	Check that it is a struct
%
	if (isstruct(CVstruct))
		Fields = fieldnames(CVstruct);
	else
		error(Error.NotStruct,'information container')
	end
	
	CVInfo.Defined	= []							;
	CVInfo			= PreProcessVolumeProper(CVInfo);
	CVInfo			= PreProcessVolumeNodes (CVInfo);
	CVInfo.Grade	= 'Pass'						;
	
%
%
% ------------------------------------------------------------------------------
	
	
	
	function LocalCVInfo = PreProcessVolumeProper(LocalCVInfo)
	% ----------------------------------------------------------------------
	%	Check the volume ID field
	%
		if     (~IsDefined('ID',Fields))
			error(Error.NotDefined,'ID number');							% Not defined
			
		elseif (~IsIntegral(CVstruct.ID,'+'))
			error('Control Volume ID must be a positive integer.');			% Wrong type
			
		else
			LocalCVInfo.Info.Printables.ID	= GetEntryInfo(CVstruct.ID);	% Output usage
			
		end
		
	% ----------------------------------------------------------------------
	%	Check for the volume Name field
	%
		if     (~IsDefined('Name',Fields))
			error(Error.NotDefined,'Name')   ; % Not defined
			
		elseif (~IsValidString(CVstruct.Name,16))
			error(Error.TooLong,'Name',16) ; %#ok<CTPCT> % Wrong type
		else
			LocalCVInfo.Info.Printables.Name = []          ; % Output usage
		end
		
		
	% ----------------------------------------------------------------------
	%	Check for the volume Node field
	%
		if    (~IsDefined('Node',Fields))
			error(Error.NotDefined,'nodal information') ; % Not defined
		elseif(~isstruct(CVstruct.Nodal))
			error(Error.NotStruct,'nodal information') ; % Wrong type
		end
		
		
	% ----------------------------------------------------------------------
	%	Check for the volume State field
	%
		if     (~IsDefined('State',Fields))
			error(Error.NotDefined,'state information')   ; % Not defined
		elseif (~isstruct(CVstruct.State))
			error(Error.NotStruct,'state information') ; % Wrong type
		end
	end
	
	
	function LocalCVInfo = CheckVolumeNodals(LocalCVInfo)
		NodeFields	= fieldnames(CVstruct.Nodal);
		NodalLocal	= CV.Nodal;
		
		if     (~IsDefined('Hnaught',NodeFields))
			error(Error.NotDefined,'starting height')   ; % Not defined
		elseif (~isnumeric(NodalLocal.Hnaught))
			error(Error.NotNumber,'starting height') ; % Wrong type
		end
		
		
	end
	
end