function Out = RemoveCharacterSingle(In,Target)
	StringSize = size(In);
	for m = 1:StringSize(1)
		Logical  = In(m,:)== Target;
		Removals = find(Logical);
		Keeps    = setdiff(1:StringSize(2),Removals);
		LocOut   = In(m,Keeps);
		if (StringSize(1) == 1)
			Out = LocOut;
		else
			Out = char(LocOut,In(m+1,:));
		end
	end
end