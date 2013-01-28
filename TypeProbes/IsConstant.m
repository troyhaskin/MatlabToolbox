function TorF = IsConstant(Vector)
	Nelem   = length(Vector)               ;
	dVec    = Vector(2) - Vector(1)        ;
	TempVec = Vector(1):dVec:Vector(Nelem) ;
	Test1   = (Nelem == length(TempVec))   ;
	if (Test1)
		Test2 = (sum(Vector == TempVec)/Nelem == 1);
		if (Test2)
			TorF = 'True'  ;
		else
			TorF = 'False' ;
		end
	else
		TorF = 'False' ;
	end
end