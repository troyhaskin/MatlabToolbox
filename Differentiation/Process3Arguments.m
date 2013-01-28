function [Source,Target,method] = Process3Arguments(Input1,Input2,Input3)

if(ischar(Input1)   && IsVector(Input2) && IsVector(Input3))
	method = Input1;
	Source = Input2;
	Target = Input3;
	Source = ReshapeCheck(Target,Source);
elseif(IsVector(Input1) && IsVector(Input2) && ischar(Input3))
	method = Input3;
	Source = Input1;
	Target = Input2;
	Source = ReshapeCheck(Target,Source);
elseif(  ischar(Input1) && isscalar(Input2) && isvector(Input3))
	method = Input1;
	Source = Input2;
	Target = Input3;
elseif(  ischar(Input1) && isvector(Input2) && isscalar(Input3))
	method = Input1;
	Source = Input3;
	Target = Input2;
elseif(  ischar(Input2) && isscalar(Input1) && isvector(Input3))
	method = Input2;
	Source = Input1;
	Target = Input3;
elseif(  ischar(Input2) && isvector(Input1) && isscalar(Input3))
	method = Input2;
	Source = Input3;
	Target = Input1;
elseif(  ischar(Input3) && isscalar(Input2) && isvector(Input1))
	method = Input3;
	Source = Input2;
	Target = Input1;
elseif(  ischar(Input3) && isvector(Input2) && isscalar(Input1))
	method = Input3;
	Source = Input1;
	Target = Input2;
else
	error('\nUnknown variable type combination passed.\n')
end






	function Logical = IsVector(VectorCheck)
		Logical = isvector(VectorCheck) && ~isscalar(VectorCheck);
	end
% ================================================================= %

end