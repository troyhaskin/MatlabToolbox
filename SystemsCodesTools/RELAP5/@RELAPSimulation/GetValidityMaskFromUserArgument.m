function ValidMask = GetValidityMaskFromUserArgument(RSim,Version)
    
    % Check if the user gave a string or a number
    if ischar(Version)
        VersionStr = Version;
        Version    = str2double(strrep(VersionStr,'.',''));
    else
        VersionStr = Interpose(num2str(Version),'.');
    end
    
    
    % Create match maskes
    Differences = Version - RSim.ValidVersionNumbers                        ;
    ExactMatch  =  (Differences == 0)                                       ;
    MajorMatch  = round(Version/100) == round(RSim.ValidVersionNumbers/100) ;
    
    
    if any(ExactMatch)
        % Exactly matches
        ValidMask = ExactMatch;
        
    elseif any(MajorMatch)
        % Matches the major version number
        
        if nnz(MajorMatch) == 1
            % Inform the user of the assumption
            fprintf(['RELAP5Simulation: User-requested version %s was not ',...
                'exactly found.\n'],VersionStr);
            fprintf(['RELAP5Simulation: Installed version %s matches ',...
                'requested major version number and will be used ',...
                'instead.\n'],RSim.ValidVersionStrings{MajorMatch});
            
            % Assign single major match array to the ValidMask
            ValidMask = MajorMatch;
            
        else
            % Multiple major matches found
            fprintf(['RELAP5Simulation: Multiple installed versions that ',...
                'match the requested major version number have been ',...
                'found.  Please select one.\n']);
            
            % Give the user the choice
            ValidMask = RSim.SetValidVersionFromUserInput(MajorMatch);
            
        end
    else
        % No matches
        fprintf(['RELAP5Simulation: User-requested version %s could not ',...
            'be found in the installation path.  Please select from ',...
            'the detected installed version list.\n'],VersionStr);
        ValidMask = RSim.GetValidityMaskFromUserInput([]);
    end
    
end % GetValidityMaskFromUserArgument