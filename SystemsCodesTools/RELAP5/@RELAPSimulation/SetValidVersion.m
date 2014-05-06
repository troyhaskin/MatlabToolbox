function [] = SetValidVersion(RSim,Version)
    
    % Set the version info if not already done so
    if isempty(RSim.ValidVersionNumbers)
        RSim.SetInstalledVersionInformation(RSim)
    end
    
    % Get the version count
    VersionCount = length(RSim.ValidVersionDirectoryNames);
    
    % Switch appropriately
    switch(VersionCount)
        
        case 0
            % No version found
            warning('RELAPSimulation:SetValidVersion:NoInstalledVersion',...
                RSim.NoInstalledVersion,RSim.PathRoot);
            
            
        case 1
            % One version found
            RSim.VersionDirectory = RSim.ValidVersionDirectoryNames{1}  ;
            RSim.VersionNumber    = RSim.ValidVersionNumbers(1)         ;
            RSim.VersionString    = RSim.ValidVersionStrings(1)         ;
            
            
        otherwise
            % Multiple versions found
            
            if any(Version ~= 0)
                % Indicates that the user DID specify a version number
                ValidMask = RSim.GetValidityMaskFromUserArgument(Version);
                
            else
                % Indicates that the user DID NOT specify a version
                ValidMask = RSim.GetValidityMaskFromUserInput([]);
                
            end
            
            % Assign version-related properties
            RSim.VersionDirectoryName = RSim.ValidVersionDirectoryNames{ValidMask}  ;
            RSim.VersionNumber        = RSim.ValidVersionNumbers(ValidMask)         ;
            RSim.VersionString        = RSim.ValidVersionStrings(ValidMask)         ;
            
            % Assign version-derived paths
            RSim.RELAPPath = [  RSim.RootPath               ,'\'    ,...
                                RSim.VersionDirectoryName   ,'\'    ,...
                                RSim.RELAPDirectoryName     ,'\'    ];
            RSim.FluidPath = [  RSim.RootPath               ,'\'    ,...
                                RSim.VersionDirectoryName   ,'\'    ,...
                                RSim.FluidDirectoryName     ,'\'    ];
    end
    
end % SetValidVersion