function [] = VerfiyInstallation(RSim)
    
    % Make sure the Root exists
    if isdir(RSim.Root)
        
        % Scan for installed versions under the root
        RSim.SetInstalledVersionInformation();
        
        % Select the version from those installed if requested
        switch (RSim.AutomateVersionValidation)
            case true
                RSim.SetValidVersion();
                RSim.SetValidFluidInformation();
        end
        
    else
        
        RSim.ThrowWarning('VerfiyInstallation:AbsentRootFolder');
    end
    
end