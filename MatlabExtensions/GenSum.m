function Summation = GenSum(Object,Method)
	
	error(nargchk(1,2,nargin))
	if (nargin == 1)
		Method = 'Total';
	end
	SumFlavor = GetSumFlavor(Object);
	
	switch (lower(SumFlavor))
		case('matlab')
			Summation = sum(Object);
		case('struct')
			Summation = SumStruct(Object,Method);
		case('cell')
			Summation = SumCell(Object,Method);
	end
	
	function SumFlavor = GetSumFlavor(Object)
		if (isnumeric(Object))
			SumFlavor = 'Matlab';
		elseif (isstruct(Object))
			SumFlavor = 'Struct';
		elseif(iscell(Object))
			SumFlavor = 'Cell';
		else
			error('Unrecognized type given to GenSum')
		end
	end
	
	function Summation = SumStruct(Object,Method)
		switch(lower(Method))
			case('total')
				Fields = fieldnames(Object);
				Fields = Alphabetize(Fields);
				SumTemp = 0;
				for k = 1:length(Fields)
					SumTemp = SumTemp + sum(Object.(char(Fields(k))));
				end
			otherwise
				error('Unrecognized or unsupported method requested.')
		end
		Summation = SumTemp;
	end
	
end