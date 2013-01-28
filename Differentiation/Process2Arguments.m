function [Source,Target,method] = Process2Arguments(Input1,Input2)

if(ischar(Input1))
	method = Input1;
	[Source,Target,nonMethod] = Process1Argument(Input2); %#ok<*NASGU>
elseif(ischar(Input2))
	method = Input2;
	[Source,Target,nonMethod] = Process1Argument(Input1);
elseif(isvector(Input1) && isscalar(Input2))
	Target = Input1;
	Source = Input2;
	method = 'ThreePoint';
elseif(isscalar(Input1) && isvector(Input2))
	Source = Input1;
	Target = Input2;
	method = 'ThreePoint';
elseif(isvector(Input1) && isvector(Input2))
	Source = Input1;
	Target = Input2;
	method = 'ThreePoint';
	Source = ReshapeCheck(Target,Source);
else
	error('\nUnknown variable type combination passed.\n')
end

end