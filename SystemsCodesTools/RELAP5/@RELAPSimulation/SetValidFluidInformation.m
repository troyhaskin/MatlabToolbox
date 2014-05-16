function [] = SetValidFluidInformation(RSim)

    % Query the Fluid Property location
    RSim.FluidPropertyFilenames = RSim.MatchNamesInDirectory(RSim.FluidAbsolutePath,'tpf');
    
    %   Get the fluid name by stripping 'tpf' from the filename.
    %   This is a local copy and not assigned to the class yet.
    FluidNames = strrep(RSim.FluidPropertyFilenames,'tpf','');

    % Allocate local arrays
    FluidNameFlagMap  = RSim.FluidNameFlagMap   ;
    AthenaNameFlagMap = RSim.AthenaNameFlagMap  ;


    %   If an Athena simulation is indicated, locally overwrite appropriate map
    %   entries with the Athena flags.
    if RSim.IsAthena

        %   Check for matching fields
        IsAthenaFluid = isfield(AthenaNameFlagMap,FluidNames);

        % If any are present
        if any(IsAthenaFluid)

            % Pull the fluid names (field names)
            AthenaFluids = FluidNames(IsAthenaFluid);
            
            % Loop and replace
            for k = 1:length(AthenaFluids)
                AthenaFluid = AthenaFluids{k};
                FluidNameFlagMap.(AthenaFluid) = AthenaNameFlagMap.(AthenaFluid);
            end

        end

    end

    
    % Contract to valid fluid fields
    IsKnownFluid = isfield(FluidNameFlagMap,FluidNames) ;
    FluidNames   = FluidNames(IsKnownFluid)             ;
    Nfluids      = length(FluidNames)                   ;
    FluidFlags   = cell(1,Nfluids)                      ;

    
    % Loop through and grab corresponding flag for the fluid name
    for k = 1 : Nfluids
        FluidFlags{k} = FluidNameFlagMap.(FluidNames{k});
    end
   
    % Assign names and flags to the class
    RSim.FluidNames = FluidNames;
    RSim.FluidFlags = FluidFlags;

end