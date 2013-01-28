function [Derivative,Source] = Differentiate(Input1,Input2,Input3)

switch(nargin)
	case(1)
		[Source,Target,method] = Process1Argument(Input1);                % External Function
	case(2)
		[Source,Target,method] = Process2Arguments(Input1,Input2);        % External Function
	case(3)
		[Source,Target,method] = Process3Arguments(Input1,Input2,Input3); % External Function
end

Nval       = length(Target);
Derivative = zeros(Nval,1);

if(~isscalar(Source))
	switch(lower(method))
		case('forward')
			Current = 1:Nval-1;
			Forward = 2:Nval;
			Derivative(Current,1) = (Target(Forward)- Target(Current))./(Source(Forward)- Source(Current));
			Derivative(Nval,1) = Derivative(Nval-1,1);
		case('threepoint')
			Derivative(1)    = (Target(2)   - Target(1))      / (Source(2)   - Source(1));
			Derivative(Nval) = (Target(Nval)- Target(Nval-1)) / (Source(Nval)- Source(Nval-1));
			LeftMask   = 1:Nval-2;
			MidMask    = 2:Nval-1;
			RightMask  = 3:Nval-0;
			hleft      = Source(MidMask) - Source(LeftMask);
			hright     = Source(RightMask) - Source(MidMask);
			LeftCoeff  = -hright./(hleft.*(hleft+hright));
			MidCoeff   = 1./hleft - 1./hright;
			RightCoeff = hleft./(hright.*(hleft+hright));
			
			Derivative(MidMask) =  LeftCoeff.*Target(LeftMask)  + ...
				MidCoeff.*Target(MidMask)   + ...
				RightCoeff.*Target(RightMask) ;
		case('fivepoint')
			
			CheckForConstantSpacing(Source);
			
			llMask = 1:Nval-4;
			lMask  = 2:Nval-3;
			mMask  = 3:Nval-2;
			rMask  = 4:Nval-1;
			rrMask = 5:Nval-0;
			iDelta = 1./(Source(2)-Source(1));
			
			Derivative(1)      =     iDelta*(Target(2)    - Target(1)      );
			Derivative(Nval)   =     iDelta*(Target(Nval) - Target(Nval-1) );
			Derivative(2)      = 0.5*iDelta*(Target(3)    - Target(1)      );
			Derivative(Nval-1) = 0.5*iDelta*(Target(Nval) - Target(Nval-2) );
			
			Derivative(mMask)  = iDelta*(Target(llMask) - 8*Target(lMask) + ...
				8*Target(rMask) - Target(rrMask))/12;
		otherwise
			error('Selected method is not at all or not currently supported.')
	end
else
	error('Input step is not yet implemented.')
end

if((size(Source,1) == 1) && ~isscalar(Source))
	Source = Source';
end


% ================================================================= %
%                       Internal Function                           %
% ================================================================= %
	function [] = CheckForConstantSpacing(Source)
		
		Delta = Source(2) - Source(1);
		SourceCheck = Source(1):Delta:Source(end);
		if (numel(SourceCheck) ~= numel(Source))
			error('Spacing is not constant.')
		end
		SourceCheck = ReshapeCheck(Source,SourceCheck);
		CheckSum    = sum((Source - SourceCheck).^2);
		Tolerance   = 1E-12;
		if(CheckSum > Tolerance)
			error('Spacing determined not to be constant within tolerance.')
		end
	end

end