function Kind = KindOfVector(Vector)
	
	Shape = size(Vector);
	
	if     (Shape(1) == 1)
		Kind = 'Row';
	elseif (Shape(2) == 1)
		Kind = 'Column';
	elseif (isempty(Vector))
		Kind = 'Empty';
	else
		Kind = 'Not';
	end

end