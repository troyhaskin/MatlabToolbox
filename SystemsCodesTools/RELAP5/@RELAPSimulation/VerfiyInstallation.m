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
        
        warning(...
            'RELAPSimulation:VerfiyInstallation:AbsentRootFolder'   ,...
            ['The default root folder for RELAP5 ''%s'' does '      ,...
            'not exist. Please specify an existing root '           ,...
            'folder to run simulations.'                            ],...
            RSim.Root);
    end
    
end