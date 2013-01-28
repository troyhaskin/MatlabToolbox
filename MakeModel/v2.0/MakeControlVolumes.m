% ---------------------------------------------------------------------------- %
%                    Get Control Volume Geometry                               %
% ---------------------------------------------------------------------------- %
function Duct = MakeControlVolumes(Duct,NodalInfo,StateInfo)
	Duct = MakeNodalization   (Duct,NodalInfo) ;
	Duct = GetThermoDynamState(Duct,StateInfo) ;
end