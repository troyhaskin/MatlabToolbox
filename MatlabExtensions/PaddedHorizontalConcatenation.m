function Concatenated = PaddedHorizontalConcatenate(ConcatCell,Padder)
    
    % Argument count check
    narginchk(1,2);
    
    % Make sure ConcatCell is a cell array
    if not(iscell(ConcatCell))
        error('MatlabExtensions:PaddedHorizontalConcatenation:InputNotCell',...
            'The first input must be a cell array of items to concatenate.');
    end
    
    % Default padder
    if (nargin == 1)
        Padder = NaN;
    elseif not(is
    end
    
    Nconcat = length(ConcatCell);
    
    
    
    
end