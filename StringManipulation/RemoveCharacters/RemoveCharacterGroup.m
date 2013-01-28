function Out = RemoveCharacterGroup(In,Target)
	TargetLength = size(Target,2);
	StringSize   = size(In);
	for m = 1:StringSize(1)
		LocOut = In(m,:);
		for n = 1:StringSize(2)
			Span = n+TargetLength-1;
			if (Span <= StringSize(2))
				Removals = n:1:Span;
				Logical  = (In(m,Removals) == Target);
				if(sum(Logical) == TargetLength)
					LocOut = DeleteGroup(Removals,In);
				end
			else
				break
			end
		end
		if    (StringSize(1) ==1)
			Out = LocOut;
		elseif(StringSize(1) ~= m)
			Out = char(LocOut,In(m+1:end,:));
		else
			Out = char(Out(1:end-1,:),LocOut);
		end
	end
	
	
	
	
	function Out = DeleteGroup(Removals,In)
		Keeps = setdiff(1:size(In,2),Removals);
		Out   = In(m,Keeps);
	end
	
end