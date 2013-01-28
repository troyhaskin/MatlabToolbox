% ---------------------------------------------------------------------- %
%                    Get Control Volume Geometry                         %
% ---------------------------------------------------------------------- %
function Duct = MakeNodalization(Duct,NodalInfo)
	
	deltaH = NodalInfo.deltaH ; % Control Volume height
	Extent = Duct.Extent      ; % Duct height
	
	
% ---------------------------------------------------------------
%  Calculate altitudes/lengths of vertical/horizontal volumes
%
	if     (Duct.deltaH <  0)
		Temp.CVEdges = Extent(1) : -deltaH : Extent(2) ;
	else
		Temp.CVEdges = Extent(1) :  deltaH : Extent(2) ;
	end
	
	if (Extent(2) ~= Temp.CVEdges(end))
		Difference = abs(Temp.CVEdges(end) - Extent(2));
		
		if (Difference >= 0.1 * deltaH)
			Temp.CVEdges	= [Temp.CVEdges,Extent(2)];
		else
			Temp.CVEdges(end) = Extent(2);
		end
	end
	
	Duct.CV.Num      = length(Temp.CVEdges) - 1;  % number of control volumes
	Sizer            = ones(Duct.CV.Num,1);
	
% ---------------------------------------------------------------
%  Struct information
%
	Duct.CV.In_fo.Type = 'ControlVolume' ;
	Duct.FL.In_fo.Type = 'FlowPaths'     ;
	
% ---------------------------------------------------------------
%  IDs to be printed
%
	Duct.CV.IDs      = (Duct.ID * 1E3) + (0:Duct.CV.Num-1)';
	Duct.FL.IDs      = (Duct.ID * 1E3) + (0:Duct.CV.Num-2)';
	
% ---------------------------------------------------------------
%  IDs that go into the Name
%
	Name.CV.IDs      = PadSpacesWithZeros(num2str((0:Duct.CV.Num-1)'));
	Name.FL.IDs      = PadSpacesWithZeros(num2str((0:Duct.CV.Num-2)'));
	
% ---------------------------------------------------------------
%  Control volume names
%
	Duct.CV.Name     = cellstr(strcat(Duct.Name,'-Vol-',Name.CV.IDs));
	Duct.FL.Name     = cellstr(strcat(Duct.Name,'-Pth-',Name.FL.IDs));
	
% ---------------------------------------------------------------
%  Define all control volume geometry items
%
	Duct.CV.Altitude  = [Temp.CVEdges(1:end-1)',Temp.CVEdges(2:end)'];
	
	Duct.CV.Volumes   = (NodalInfo.FlowArea*deltaH) * Sizer;
	Duct.CV.FlowArea  = NodalInfo.FlowArea          * Sizer;
	Duct.CV.FracOpen  = NodalInfo.FracOpen          * Sizer;
	Duct.CV.HydroDiam = NodalInfo.HydroDiam         * Sizer;
	
	Duct.CV.deltaH    = deltaH;
	Duct.FL.Length    = deltaH;
	
% ---------------------------------------------------------------
%  Define the inlet and outlet as defined by Hnaught and FlowDir
%        This is used in multiple duct linking.
	Duct.CV.Start = {Duct.CV.Name{1},Duct.CV.Altitude(1)};
	Duct.CV.End   = {Duct.CV.Name{end},Duct.CV.Altitude(end)};
	
end
% ---------------------------------------------------------------------- %