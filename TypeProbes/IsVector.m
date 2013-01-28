function Logical = IsVector(Object)
	
	Type = WhatIsThis(Object);
	
	switch(Type)
		case('numeric')
			Logical = IsActuallyVector(Object);
		case('cell')
			Logical = 0;
			
			for k = 1 : length(Object)
				Logical = IsActuallyVector(Object{k}) || Logical ;
			end
			
		otherwise
			error('Unsupported class ''%s'' passed to IsVector.',Type);
	end
	
	function LogicalLocal = IsActuallyVector(Argument)
		LogicalLocal = isvector(Argument) && ~isscalar(Argument);
	end
end