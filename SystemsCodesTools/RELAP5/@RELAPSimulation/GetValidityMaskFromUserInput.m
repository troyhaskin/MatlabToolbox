function ValidMask = GetValidityMaskFromUserInput(RSim,Mask)
    
    if isempty(Mask)
        VersionStrings = RSim.ValidVersionStrings;
    else
        VersionStrings = RSim.ValidVersionStrings(Mask);
    end
    
    NotDone = true;
    
    while NotDone
        RSim.Print('Detected, installed versions:\n');
        RSim.Print('\to %s\n',VersionStrings{:});
        RSim.Print('Selection:');
        Selection = strtrim(input('','s'));
        
        NotDone = not(any(strcmp(Selection,VersionStrings)));
        
        if NotDone
            RSim.Print('\n');
            RSim.Print('***Incorrect Selection***\n\n');
        end
    end
    
    ValidMask = cellfun( @(c) not(isempty(c))                   ,...
        strfind(RSim.ValidVersionStrings,Selection));
    
end % SetValidVersionFromUserInput