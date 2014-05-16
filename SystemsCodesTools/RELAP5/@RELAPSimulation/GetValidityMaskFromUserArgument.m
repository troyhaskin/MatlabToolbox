function ValidMask = GetValidityMaskFromUserArgument(RSim)
    
    % Create match maskes
    Differences = RSim.VersionNumber - RSim.ValidVersionNumbers                         ;
    ExactMatch  =  (Differences == 0)                                                   ;
    MajorMatch  = round(RSim.VersionNumber/100) == round(RSim.ValidVersionNumbers/100)  ;
    
    
    if any(ExactMatch)
        % Exactly matches
        ValidMask = ExactMatch;
        
    elseif any(MajorMatch)
        % Matches the major version number
        
        if nnz(MajorMatch) == 1
            % Inform the user of the assumption
            RSim.Print(...
                'User-requested version %s was not exactly found.\n',...
                RSim.VersionString);
            RSim.Print(...
                ['Installed version %s matches requested major version number ' ,...
                'and will be used instead.\n']                                  ,...
                RSim.ValidVersionStrings{MajorMatch});
            
            % Assign single major match array to the ValidMask
            ValidMask = MajorMatch;
            
        else
            % Multiple major matches found
            RSim.Print(...
                ['Multiple installed versions that match the requested major '  ,...
                'version number have been found.  Please select one.\n'         ]);
            
            % Give the user the choice
            ValidMask = RSim.SetValidVersionFromUserInput(MajorMatch);
            
        end
    else
        % No matches
        RSim.Print(...
            ['User-requested version %s could not be found in the installation ',...
            'path.  Please select from the detected installed version list.\n'] ,...
            RSim.VersionString);
        ValidMask = RSim.GetValidityMaskFromUserInput([]);
    end
    
end % GetValidityMaskFromUserArgument