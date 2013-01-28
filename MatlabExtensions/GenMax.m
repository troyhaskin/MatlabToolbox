function Maximum = GenMax(Object)
	
	MaxFlavor = GetMaxFlavor(Object);
	
	switch (lower(MaxFlavor))
		case('matlab')
			Maximum = DoubleMax(Object);
		case('struct')
			Maximum = StructMax(Object);
		case('cell')
			Maximum = CellMax(Object);
	end
	
	function MaxFlavor = GetMaxFlavor(Object)
		if (isnumeric(Object))
			MaxFlavor = 'Matlab';
		elseif (isstruct(Object))
			MaxFlavor = 'Struct';
		elseif(iscell(Object))
			MaxFlavor = 'Cell';
		else
			fprintf('\n');
			error('Unrecognized type given to GenMax.');
		end
	end
	
	function Maximum = StructMax(Object)
		Fields  = fieldnames(Object);
		FirstField = char(Fields(1));
		Maximum = max(max(Object.(FirstField)));
		for k = 2:length(Fields)
			LocField = char(Fields(k));
			FieldMax = DoubleMax(Object.(LocField));
			Maximum = max(FieldMax,Maximum);
		end
	end
	
	function Maximum = CellMax(Object)
		Maximum = DoubleMax(cell2mat(Object(1)));
		for k = 2:length(Object)
			LocMax  = DoubleMax(cell2mat(Object(k)));
			Maximum = max(LocMax,Maximum);
		end
	end
	
	function Maximum = DoubleMax(Object)
		Maximum = max(max(Object));
	end
	
end