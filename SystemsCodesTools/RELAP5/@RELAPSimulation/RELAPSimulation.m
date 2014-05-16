classdef RELAPSimulation < handle
    
    
    properties
        
        % Root (installation) directory
        Root = 'C:\r5' ;
        
        % Paths for the RELAP executable (relative to the chosen Version's root)
        RELAPDirectoryName = 'relap';
        RELAPRelativePath  = ''     ;
        RELAPAbsolutePath  = ''     ;
        
        % Paths for the Fluid property files  (relative to the chosen Version's root)
        FluidDirectoryName = 'relap';
        FluidRelativePath  = ''     ;
        FluidAbsolutePath  = ''     ;
        
        % Version information
        VersionNumber        = ''   ;
        VersionString        = ''   ;
        VersionDirectoryName = ''   ;
        
        % Options
        Overwrite     = true    ;
        AutoIncrement = false   ;
        IsAthena      = false   ;
        
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
        
        % Auto-detected version information
        ValidVersionDirectoryNames = {};
        ValidVersionStrings        = {};
        ValidVersionNumbers        = [];
        
        % Boolean to turn on/off automated version detection
        AutomateVersionValidation  = true;
        
        
        % Detected fluid property files
        FluidPropertyFilenames = {};
        FluidNames             = {};
        FluidFlags             = {};
        
        % Known fluids RELAP supports
        FluidNameFlagMap = struct(...
            'he','b','d2o','d','n2','e','glyc','g','h2','h',...
            'k','k','li','l','na','m','nak','q','lipb','t',...
            'nh3','u','vertrel','v','h2o','w','dowa','x',...
            'r134an','y','xen','E','co2','G','blood','H',...
            'henxen','J','bipb','L','hen','M','pb','Q','h2o95','S',...
            'ms1','U','ms2','V','h2on','W','ms3','Y','ms4','Z');
        AthenaNameFlagMap = struct('d2o','D','h2o','T');
        
    end % properties
    
    
    methods
        
        % ================================================== %
        %                   Constructor                      %
        % ================================================== %
        function RSim = RELAPSimulation(Name,varargin)
            
            if (nargin == 0)
                RSim.ThrowError('Constructor:NameMissing');
            end
            
            if ( nargin >= 1 )
                RSim.SimulationName       = Name;
                RSim.InputFileName        = [Name,'.i'  ];
                RSim.OutputFileName       = [Name,'.o'  ];
                RSim.SequentialFileName   = [Name,'.r'  ];
                RSim.DirectAccessFileName = [Name,'.rr' ];
                RSim.PlotFileName         = [Name,'.plt'];
                RSim.StripFileName        = [Name,'.s'  ];
            end
            
            
            switch (length(varargin))
                
                case 0
                    % Set Version to 0 for default behavior if automation is true
                    RSim.VersionNumber = 0;
                    
                    
                case 1
                    %   Assign the VersionNumber and VersionString through this 
                    %   helper method.
                    RSim.HandleVersionInputArgument(varargin{1});
                    
                otherwise
                    
                    %   Pull all Key-Value pairs
                    Keys   = varargin(1:2:end)  ;
                    Values = varargin(2:2:end)  ;
                    
                    % Check for a Version key-value pair
                    IsVersion = strcmp('Version',Keys);
                    
                    if any(IsVersion)
                        
                        % Deal with a user-supplied Version (string or number)
                        RSim.HandleVersionInputArgument(Values{IsVersion});
                        
                        % Contract out the Version pair
                        Keys   = Keys(not(IsVersion));
                        Values = Values(not(IsVersion));

                    end
                    
                    %   Contract to only valid property names
                    IsProperty = isprop(RSim,Keys);
                    Keys       = Keys(IsProperty);
                    Values     = Values(IsProperty);
                    
                    % Assign key-value pairs to the instance.
                    for k = 1:Nkeys
                        RSim.(Keys{k}) = Values{k};
                    end

            end
            
            % Attempt to set the installation information
            RSim.VerfiyInstallation();
            
            
        end % RELAPSimulation
        
        
        function [] = HandleVersionInputArgument(RSim,VersionArgument)
            if ischar(VersionArgument)
                
                %   Assign the string and number version IDs
                RSim.VersionString = VersionArgument    ;
                
                
                if (length(VersionArgument) == 5)
                    %   I.e., '4.0.0'
                    Scale = 1;

                elseif (length(VersionArgument) == 3)
                    %   I.e., '4.0'
                    Scale = 10;

                elseif any(length(VersionArgument) == [1;2])
                    %   I.e., '4' or '4.'
                    Scale = 100;

                else
                    Scale = 1;
                end

                RSim.VersionNumber = Scale*str2double(strrep(VersionArgument,'.',''))   ;

            elseif isnumeric(VersionArgument) && isscalar(VersionArgument)
                
                %   Assign the string and number version IDs
                RSim.VersionNumber = VersionArgument                                ;
                RSim.VersionString = RSim.Interlope(num2str(VersionArgument),'.')   ;
                
                
            elseif islogical(VersionArgument)
                
                % Set the automation to the argument's value
                RSim.AutomateVersionValidation = VersionArgument;
                
                % Set Version to 0 for default behavior if automation is true
                RSim.VersionNumber = 0;
                
            else
                RSim.ThrowError('Constructor:InvalidVersionClass',class(VersionArgument));
            end

        end % HandleVersionInputArgument
        
        
        
    end % methods
    
    
    
    
    
    % ===================================== %
    %            Static Methods             %
    % ===================================== %
    methods(Static = true)
        
        MatchedNames = MatchNamesInDirectory(Directory,Pattern)
        Interposed   = Interpose(String,Interloper)
        []           = Print(String,varargin);
        
    end % methods
    

    % ===================================== %
    %           Private Methods             %
    % ===================================== %
    methods(Access = private , Hidden = true)
        
        [] = ThrowError  (RSim, ErrorID  , varargin)
        [] = ThrowWarning(RSim, WarningID, varargin)
        
    end % methods
    
    
    
end % classdef
