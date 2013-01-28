function Out = GeneralRemoveChar(In,varargin)
	LocOut = In;
	for k = 1:length(varargin)
		TargetCharacter = char(varargin(k));
		LocOut          = RemoveCharCore(LocOut,TargetCharacter);
	end
	Out = LocOut;
end