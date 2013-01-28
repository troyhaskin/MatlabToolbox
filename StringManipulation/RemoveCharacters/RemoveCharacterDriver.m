function Out = RemoveCharacterDriver(In,Target)
	if(numel(Target) == 1)
		Out = RemoveCharacterSingle(In,Target);
	else
		Out = RemoveCharacterGroup(In,Target);
	end
	Out = deblank(Out);
end