function [] = SetValidVersion(RSim)
    
    % Set the version info if not already done so
    if isempty(RSim.ValidVersionNumbers)
        RSim.SetInstalledVersionInformation();
    end
    
    % Get the version count
    VersionCount = length(RSim.ValidVersionDirectoryNames);
    
    % Switch appropriately
    switch(VersionCount)
        
        case 0
            % No version found
            warning(...
                'RELAPSimulation:SetValidVersion:NoInstalledVersion',...
                ['No installation directory for a version of RELAP ',...
                'was not found in the root directory ''%s''. Not '  ,...
                'simulations can be run.'                           ],...
                RSim.Root);
            
            
        case 1
            % One version found
            RSim.VersionDirectory = RSim.ValidVersionDirectoryNames{1}  ;
            RSim.VersionNumber    = RSim.ValidVersionNumbers(1)         ;
            RSim.VersionString    = RSim.ValidVersionStrings(1)         ;
            
            
        otherwise
            % Multiple versions found
            
            if any(RSim.VersionNumber ~= 0)
                % Indicates that the user DID specify a version number
                ValidMask = RSim.GetValidityMaskFromUserArgument();
                
            else
                % Indicates that the user DID NOT specify a version
                ValidMask = RSim.GetValidityMaskFromUserInput([]);
                
            end

            
            % ================================================================ %
            %                   Version Information Setting                    %
            % ================================================================ %
            % Assign version-related properties
            RSim.VersionDirectoryName = RSim.ValidVersionDirectoryNames{ValidMask}  ;
            RSim.VersionNumber        = RSim.ValidVersionNumbers(ValidMask)         ;
            RSim.VersionString        = RSim.ValidVersionStrings(ValidMask)         ;
            
            % Assign version-derived absolute paths
            RSim.RELAPAbsolutePath = [  RSim.Root                   ,'\'    ,...
                                        RSim.VersionDirectoryName   ,'\'    ,...
                                        RSim.RELAPDirectoryName             ];
            RSim.FluidAbsolutePath = [  RSim.Root                   ,'\'    ,...
                                        RSim.VersionDirectoryName   ,'\'    ,...
                                        RSim.FluidDirectoryName             ];

            % Assign version-derived relative (to Version root) paths
            RSim.RELAPRelativePath = ['.\',RSim.RELAPDirectoryName];
            RSim.FluidRelativePath = ['.\',RSim.FluidDirectoryName];

    end
    
end % SetValidVersion