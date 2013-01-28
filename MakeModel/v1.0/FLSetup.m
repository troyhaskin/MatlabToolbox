function FPath = FLSetup(CVol)
	FlowArea        = 3.71612;
	FPath.Num       = length(CVol.IDs) - 1;
	FPath.FlowAreas = repmat(FlowArea,FPath.Num,1);
	FPath.OpenFrac  = repmat(1.00,FPath.Num,1);
	FPath.Dh        = repmat(1.9367,FPath.Num,1);
	FPath.Seg       = repmat(1,FPath.Num,1);
	FPath.Lengths   = GetFPathLengths(CVol.RelHeight);
	FPath.IDs       = (0:1:FPath.Num-1)' + 1000;
	ColdIDs         = (0:1:FPath.Num/2-1)';
	BotIDs          = [FPath.Num/2;FPath.Num/2+1];
	HotIDs          = (FPath.Num/2+2:1:FPath.Num)';
	ColdNames       = strcat('Path-',num2str(ColdIDs),'-Cld-',num2str(ColdIDs));
	BotNames        = strcat('Path-',num2str(BotIDs),'-Bot-',num2str((BotIDs)-BotIDs(1)));
	HotNames        = strcat('Path-',num2str(HotIDs),'-Hot-',num2str((HotIDs)-HotIDs(1)));
	FPath.Names     = strvcat(ColdNames,BotNames,HotNames); %#ok<VCAT>
	FPath.Names     = PadSpacesWithZeros(FPath.Names);
	FPath.VolFrom   = CVol.Names(1:end-1,:);
	FPath.VolTo     = CVol.Names(2:end,:);
	Pvt             = (length(CVol.CoarseHeight)+1)/2;
	FPath.ZFrom     = CVol.CoarseHeight([2:Pvt-1,Pvt,Pvt,Pvt+1:end-1],1);
	FPath.ZTo       = CVol.CoarseHeight([2:Pvt-1,Pvt,Pvt,Pvt+1:end-1],1);

	function Lengths = GetFPathLengths(RelHeight)
		LeftMask  = 1:1:length(RelHeight)-1;
		RightMask = 2:1:length(RelHeight);
		Lengths   = 0.5*(RelHeight(LeftMask) + RelHeight(RightMask));
	end
end