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
        FileNames = struct(...
            'Input'       , 'input'  , 'Output', 'output', 'Sequential', 'sequential',...
            'DirectAccess', 'direct' , 'Plot'  , 'plot'  , 'StripOut'  , 'strip'     ,...
            'Stratch'     , 'scratch', 'Info'  , 'info'  , 'Replay'    , 'replay'    ,...
            'SCDAP'       , 'scdap'  , 'Dump1' , 'dump1' , 'Dump2'     , 'dump2'     ,...
            'StripInput'  , '');
        
        
        % Boolean to turn on/off automated version detection
        AutomateVersionValidation  = true;
        
    end % properties
    
    
    properties(Access = private , Hidden = true)
        
        % Auto-detected version information
        ValidVersionDirectoryNames = {};
        ValidVersionStrings        = {};
        ValidVersionNumbers        = [];
        
        
        %
        %   FileName flags
        %
        FileNamesFlagMap = struct(...
            'Input'       , 'i', 'Output', 'o', 'Sequential', 'r'   ,...
            'DirectAccess', 'R', 'Plot'  , 'p', 'Strip'     , 's'   ,...
            'Stratch'     , 'f', 'Info'  , 'j', 'Replay'    , 'c'   ,...
            'SCDAP'       , 'a', 'Dump1' , 'A', 'Dump2'     , 'B'   );
        
        % Detected fluid property files
        FluidPropertyFilenames = {};
        FluidNames             = {};
        FluidFlags             = {};
        
        
        %
        % Known fluids RELAP supports
        %
        FluidNameFlagMap = struct(...
            'he'  , 'b', 'd2o'    , 'd', 'n2'   , 'e', 'glyc'  , 'g', 'h2'    , 'h' ,...
            'k'   , 'k', 'li'     , 'l', 'na'   , 'm', 'nak'   , 'q', 'lipb'  , 't' ,...
            'nh3' , 'u', 'vertrel', 'v', 'h2o'  , 'w', 'dowa'  , 'x', 'r134an', 'y' ,...
            'xen' , 'E', 'co2'    , 'G', 'blood', 'H', 'henxen', 'J', 'bipb'  , 'L' ,...
            'hen' , 'M', 'pb'     , 'Q', 'h2o95', 'S', 'ms1'   , 'U', 'ms2'   , 'V' ,...
            'h2on', 'W', 'ms3'    , 'Y', 'ms4'  , 'Z'                               );

        AthenaNameFlagMap = struct('d2o','D','h2o','T');
        
    end % properties
    
    
    methods
        
        % ================================================== %
        %                   Constructor                      %
        % ================================================== %
        function RSim = RELAPSimulation(Name,varargin)
            
            %
            %   A name for the simulation MUST BE given.
            %
            if (nargin == 0)
                error(...
                    'RELAPSimulation:Constructor:NameMissing'           ,...
                    ['At least one argument, the simulation name, is '  ,...
                    'required for instantiation.']);
            end


            %
            %   With a name given, auto-create the default filenames.
            %
            if ( nargin >= 1 ) && ischar(Name)
                RSim.SimulationName       = Name;
                RSim.InputFileName        = [Name,'.i'  ];
                RSim.OutputFileName       = [Name,'.o'  ];
                RSim.SequentialFileName   = [Name,'.r'  ];
                RSim.DirectAccessFileName = [Name,'.rr' ];
                RSim.PlotFileName         = [Name,'.plt'];
                RSim.StripFileName        = [Name,'.s'  ];
            else
                error(...
                    'RELAPSimulation:Constructor:NameMustBeAString' ,...
                    'Input argument ''Name'' must be a string.');
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
                    IsProperty = cellfun(...
                                    @(k) isprop(RSim,k),Keys,'UniformOutput',true) ;
                    IsFileName = isfield(RSim.FileNames,Keys);
                    Nkeys      = nnz(IsProperty)    ;
                    Nnames     = nnz(IsFileName)    ;
                    Keys       = [Keys(IsProperty)  , Keys(IsFileName)  ];
                    Values     = [Values(IsProperty), Values(IsFileName)];
                    
                    %
                    % Assign key-value pairs to the instance properties.
                    %
                    for k = 1:Nkeys
                        RSim.(Keys{k}) = Values{k};
                    end
                    
                    %
                    % Assign FileNames to the instance's struct
                    %
                    for k = Nkeys + (1:Nnames)
                        RSim.FileNames.(Keys{k}) = Values{k};
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
                error(...
                    'RELAPSimulation:Constructor:InvalidVersionClass'       ,...j
                    ['Version specification of class ''%s'' is not '        ,...
                    'supported. Please enter a string (e.g., ''2.3.6'') '   ,...
                    'or its numerical equivalent (e.g., 236).'              ],...
                    class(VersionArgument));
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
