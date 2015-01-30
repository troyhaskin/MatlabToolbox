function Concatenated = PaddedHorizontalConcatenate(ConcatCell,Padding)
    
    % Argument count check
    narginchk(1,2);
    
    % Make sure ConcatCell is a cell array
    if not(iscell(ConcatCell))
        error('MatlabExtensions:PaddedHorizontalConcatenation:InputNotCell',...
            'The first input must be a cell array of items to concatenate.');
    end
    
    % Default padder
    if (nargin == 1)
        Padding = NaN;
    elseif not(isscalar(Padding))
        error('MatlabExtensions:PaddedHorizontalConcatenation:PadderNotScalar',...
            'The padding must be a scalar value.');
    end
    
    % Type homogeneity check
    c0 = ConcatCell{1};
    
    if isnumeric(c0)
        
        if all(cellfun(@(c)isnumeric(c),ConcatCell(2:end)))
        else
        end
    
    elseif iscell(c0)
        
    elseif ischar(c0)
        
    elseif islogical(c0)
        
    else
        error('MatlabExtensions:PaddedHorizontalConcatenation:InvalidConcatType',...
            'Unsupported class ''%s'' passed as a concatenation argument.',class(c0));
    end
    
    
    
        
    % Routine
    Nconcat = length(ConcatCell);

end
    
    