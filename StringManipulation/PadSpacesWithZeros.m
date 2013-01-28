function Out = PadSpacesWithZeros(In)
	
	Out = In;                    % Preallocate 
	
	for m = 1:size(In,2)         % Loop through columns
		Mask = (In(:,m) == ' '); % Logical mask looking for spaces
		Out(Mask,m) = '0';       % Replace spaces with zeros
	end
	
end