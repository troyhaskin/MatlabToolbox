function ValidMask = GetValidityMaskFromUserInput(RSim,Mask)
    
    if isempty(Mask)
        VersionStrings = RSim.ValidVersionStrings;
    else
        VersionStrings = RSim.ValidVersionStrings(Mask);
    end
    
    NotDone = true;
    
    while NotDone
        fprintf('RELAP5Simulation: Detected, installed versions:\n');
        fprintf('RELAP5Simulation: \to %s\n',VersionStrings{:});
        fprintf('RELAP5Simulation: Selection:');
        Selection = strtrim(input('','s'));
        
        NotDone = not(any(strcmp(Selection,VersionStrings)));
        
        if NotDone
            fprintf('\nRELAP5Simulation:  ***Incorrect Selection***\n\n');
        end
    end
    
    ValidMask = cellfun( @(c) not(isempty(c))                   ,...
        strfind(RSim.ValidVersionStrings,Selection));
    
end % SetValidVersionFromUserInput