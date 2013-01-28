function Type = WhatIsThis(Object,DescriptionLevel)
    
    if (nargin < 2)
        DescriptionLevel = 'generic';
    elseif not(ischar(DescriptionLevel))
        error('MyMatlabToolbox:TypesProbes:NonCharacterSwitch',...
            'The DescriptionLevel optional input to WhatIsThis must be a string.');
    end
    
    RawClass = class(Object);
    
    switch(strtrim(lower(DescriptionLevel)))
        case 'generic'
            Type = GetGenericClassName(RawClass);
        case 'raw'
            Type = RawClass;
        case 'readable'
        case 'detailed'
        otherwise
    end
    
end

function Type = GetGenericClassName(RawClass)
    
    MatchInThisList = @(List) any(strcmp(RawClass,List));
    
    if MatchInThisList(ListOfNumericTypes())
        Type = 'numeric';
        
    elseif MatchInThisList(ListOfTextTypes())
        Type = 'char';
        
    elseif MatchInThisList(ListOfBooleanTypes())
        Type = 'logical';
        
    elseif MatchInThisList(ListOfStructTypes())
        Type = 'struct';
        
    elseif MatchInThisList(ListOfCellTypes())
        Type = 'cell';
        
    elseif MatchInThisList(ListOfFunctionHandleTypes());
        Type = 'function handle';
        
    else
        Type = RawClass;    % This indicates a class that is not in lists above
                            % and can only be described by the raw class name.
    end

end

