function [] = ThrowError(RSim,ErrorID,varargin) %#ok<INUSL>
    
    
    switch(ErrorID)
        case('Constructor:NameMissing')
            error(...
                'RELAPSimulation:Constructor:NameMissing'           ,...
                ['At least one argument, the simulation name, is '  ,...
                'required for instantiation.']);
            
        case('Constructor:InvalidVersionClass')
            error(...
                'RELAPSimulation:Constructor:InvalidVersionClass'       ,...j
                ['Version specification of class ''%s'' is not '        ,...
                'supported. Please enter a string (e.g., ''2.3.6'') '   ,...
                'or its numerical equivalent (e.g., 236).'              ],...
                varargin{:});
            
        otherwise
    end
    
    
    
end