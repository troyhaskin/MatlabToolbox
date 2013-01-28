function Duct = MakeDuct(Duct,NodalInfo,StateInfo,varargin)

	Duct.In_fo.Type = 'Duct';
	
	Duct.Extent(1) = Duct.Hnaught                   ;
	Duct.Extent(2) = Duct.Hnaught + Duct.deltaH     ;
	
	
    Tools = ToolboxForMakeDuct()                    ;
	Duct  = Tools.GetID(Duct)                       ;
	Duct  = Tools.FillDefaults(Duct)                ;
	Duct  = Tools.ParseVarArgs(varargin,Duct)       ;
	Duct  = Tools.GetFlowDir(Duct)                  ;
	
 	Duct  = MakeControlVolumes(Duct,NodalInfo,StateInfo);
	
end