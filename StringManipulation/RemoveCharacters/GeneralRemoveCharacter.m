function Out = GeneralRemoveCharacter(In,varargin)
	LocOut = In;
	for k = 1:length(varargin)
		TargetCharacter = char(varargin(k));
		LocOut          = RemoveCharacterDriver(LocOut,TargetCharacter);
	end
	Out = LocOut;
end