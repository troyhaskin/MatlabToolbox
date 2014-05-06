function [] = VerfiyInstallation(RSim,Version)
    
    % Make sure the Root exists
    if isdir(RSim.PathRoot)
        
        % Scan for installed versions under the root
        RSim.SetInstalledVersionInformation();
        
        % Select the version from those installed if requested
        switch (RSim.AutomateVersionValidation)
            case true
                RSim.SetValidVersion(Version);
                RSim.SetValidFluidInformation();
        end
        
    else
        warning('RELAPSimulation:VerfiyInstallation:AbsentRootFolder',...
            RSim.AbsentRootFolder,RSim.PathRoot);
    end
    
end