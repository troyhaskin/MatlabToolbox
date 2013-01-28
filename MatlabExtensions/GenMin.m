function Minimum = GenMin(Object)
	
	MinFlavor = GetMinFlavor(Object);
	
	switch (lower(MinFlavor))
		case('matlab')
			Minimum = DoubleMin(Object);
		case('struct')
			Minimum = StructMin(Object);
		case('cell')
			Minimum = CellMin(Object);
	end
	
	function MinFlavor = GetMinFlavor(Object)
		if (isnumeric(Object))
			MinFlavor = 'Matlab';
		elseif (isstruct(Object))
			MinFlavor = 'Struct';
		elseif(iscell(Object))
			MinFlavor = 'Cell';
		else
			fprintf('\n');
			error('Unrecognized type given to GenMin.');
		end
	end
	
	function Minimum = StructMin(Object)
		Fields     = fieldnames(Object);
		FirstField = char(Fields(1));
		Minimum    = DoubleMin(Object.(FirstField));
		for k = 2:length(Fields)
			LocField = char(Fields(k));
			FieldMin = DoubleMin(Object.(LocField));
			Minimum = min(FieldMin,Minimum);
		end
	end
	
	function Minimum = CellMin(Object)
		Minimum = DoubleMin(cell2mat(Object(1)));
		for k = 2:length(Object)
			LocMin  = DoubleMin(cell2mat(Object(k)));
			Minimum = min(LocMin,Minimum);
		end
	end
	
	function Minimum = DoubleMin(Object)
		Minimum = min(min(Object));
	end
	
end