classdef RELAPSimulation < handle
    
    
    properties
        
        % Path information
        PathRoot             = 'C:\r5'  ;
        VersionNumber        = ''       ;
        VersionString        = ''       ;
        VersionDirectoryName = ''       ;
        FluidDirectoryName   = 'relap'  ;
        RELAPDirectoryName   = 'relap'  ;
        
        % Options
        Overwrite     = true    ;
        AutoIncrement = false   ;
        
        % Simulation information
        SimulationName          = ''    ;
        InputFileName           = ''    ;
        OutputFileName          = ''    ;
        SequentialFileName      = ''    ;
        DirectAccessFileName    = ''    ;
        PlotFileName            = ''    ;
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
        
        
        
        ValidVersionDirectoryNames = {};
        ValidVersionStrings        = {};
        ValidVersionNumbers        = [];
        
        AutomateVersionValidation = true;
        
        RELAPPath = [];
        FluidPath = [];
        
    end % properties
    
    
    methods
        
        % ================================================== %
        %                   Constructor                      %
        % ================================================== %
        function RSim = RELAPSimulation(Name,Version)
            
            if ( nargin >= 1 )
                RSim.SimulationName       = Name;
                RSim.InputFileName        = [Name,'.i'  ];
                RSim.OutputFileName       = [Name,'.o'  ];
                RSim.SequentialFileName   = [Name,'.r'  ];
                RSim.DirectAccessFileName = [Name,'.rr' ];
                RSim.PlotFileName         = [Name,'.plt'];
                RSim.StripFileName        = [Name,'.s'  ];
            end
            
            if ( nargin >= 2 )
                
                if ischar(Version)

                    % Convert the string to the numeric equivalent
                    Version = str2double(strrep(Version,'.',''));

                elseif islogical(Version)

                    % Set the automation to the argument's value
                    RSim.AutomateVersionValidation = Version;
                    
                    % Set Version to 0 for default behavior if automation is true
                    Version = 0;

                else
                    warning('RELAPSimulation:Constructor:InvalidVersionClass',...
                            ['Version specification of class ''%s'' is not ',...
                             'supported. Please enter a string (e.g., ''2.3.6'') ',...
                             'or its numerical equivalent (e.g., 236).'],class(Version));
                end
                
            else
                Version = 0;
            end
            
            % Attempt to set the installation information
            RSim.VerfiyInstallation(Version);


        end % RELAPSimulation
        
        
    end % methods
    
    
    
end % classdef




function Interposed = Interpose(String,Interloper) %#ok<DEFNU>

    Nstring    = length(String);
    
    
    Interposed(2 * Nstring - 1) = ' ';
    
    Interposed(1:2:end) = String;
    Interposed(2:2:end) = Interloper;
    
end % Interpose