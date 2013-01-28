function [Source,Target,method] = Process1Argument(Input1)

CheckSingleInput(Input1);

if(size(Input1,1) == 2)
	Input1 = Input1';
end

Source = Input1(:,1);
Target = Input1(:,2);
method = 'ThreePoint';




	function [] = CheckSingleInput(Input)
		if    (isvector(Input))
			error('\nGiven a vector only.  Need dependent and independent/step values.')
		elseif(ischar(Input))
			error('\nGiven a string only.  Need dependent and independent/step values.')
		elseif(size(Input,1) == size(Input,2))
			error('\nGiven a square matrix. Can not tell dependent from independent values.')
		end
	end

end