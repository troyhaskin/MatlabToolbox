classdef RELAPSimulation < handle
    
    
    properties
        
        % Path information
        PathRoot                = 'C:\r5\'  ;
        VersionDirectory        = ''        ;
        FluidPropertyDirectory  = 'relap'   ;
        RELAPFolder             = 'relap'   ;


        % Simulation information
        SimulationName          = ''    ;
        InputFileName           = ''    ;
        OutputFileName          = ''    ;
        SequentialFileName      = ''    ;
        DirectAccessFileName    = ''    ;
        StripFileName           = ''    ;
        SimulationDirectory     = pwd() ;

    end % properties
    
    
    properties(Access = private , Hidden = true)
        
        NoInstalledVersion = ['No installation directory for a version of RELAP ',...
                              'was not found in the root directory ''%s''. Not ',...
                              'simulations can be run.'];

        AbsentRootFolder = ['The default root folder for RELAP5 ''%s'' does ',...
                            'not exist. Please specify an existing root ',...
                            'folder to run simulations.'];
    end % properties


    methods
        
        function RSim = RELAPSimulation(Name)
            
            if (nargin == 1)
                RSim.SimulationName       = Name;
                RSim.InputFileName        = [Name,'.i' ];
                RSim.OutputFileName       = [Name,'.o' ];
                RSim.SequentialFileName   = [Name,'.r' ];
                RSim.DirectAccessFileName = [Name,'.rr'];
                RSim.StripFileName        = [Name,'.s' ];
            end


            if isdir(RSim.PathRoot)
                
                Directories             = dir(RSim.PathRoot);
                RELAPVersionDirectories = Directories       ;
                RELAPVersionCount       = 0                 ;
                
                for k = 1:length(Directories)

                    Directory = Directories(k);
                    if strfind(Directory.name, 'r3d')
                        RELAPVersionCount = RELAPVersionCount + 1;
                        RELAPVersionDirectories(RELAPVersionCount) = Directory;
                    end

                end

                % Pull the actual RELAPVersionDirectories
                RELAPVersionDirectories = RELAPVersionDirectories(1:RELAPVersionCount);


                switch(RELAPVersionCount)

                    % No version found
                    case 0
                        warning('RELAPSimulation:Constructor:NoInstalledVersion',...
                                RSim.NoInstalledVersion,RSim.PathRoot);


                    % One version found
                    case 1
                        RSim.VersionDirectory = RELAPVersionDirectories(1).name;


                    % Multiple versions found
                    otherwise
                        fprintf('Multiple versions of RELAP were found in the root folder.  Choose one:\n');

                end
                
                
            else
                warning('RELAPSimulation:Constructor:AbsentRootFolder',...
                        RSim.AbsentRootFolder,RSim.PathRoot);
            end
            
        end % RELAPSimulation
        
        
    end % methods
    
    
    
end % classdef