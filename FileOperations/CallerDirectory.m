function TheCallerDirectory = CallerDirectory(Level)
    %   CallerDirectory:
    %       Return the directory of any function in the current run stack.
    %
    %   Note:
    %       For this function, the term Caller (with a capital 'C') refers to the function
    %       that calls this function and acts as a reference point for the levels.
    %
    %   Inputs:
    %       Level (Optional):
    %           Purpose:
    %               Determines how far up the stack to go before returning the directory
    %           Default: 
    %               0 
    %           Values:
    %               -1 => This function   (CallerDirectory.m)
    %                0 => Caller
    %                1 => caller of Caller           ('parent')
    %                2 => caller of caller of Caller ('grandparent');
    %                ...
    %   
    %   Outputs:
    %       o   The directory of the function at the requested level with an appended
    %           file separator.
    %       o   If the stack is empty, the current working directory (pwd) is returned.  
    %       o   If the requested level is greater than the number of stack entries,
    %           the last entry's directory is returned.
    %
    
    
    
    % Simple processing for the Level options
    if (nargin == 0) || isempty(Level)
        Level = 0;
        
    elseif ischar(Level)
        switch(lower(Level))
            case('parent')
                Level = 1;
                
            case('grandparent')
                Level = 2;
                
            case('caller')
                Level = 0;
                
            otherwise
                error('MatlabToolBox:FileOperations:UnsupportedLevel',...
                    'Unknown level option ''%s'' passed.',Level);
        end
    elseif not(isnumeric(Level))
        error('MatlabToolBox:FileOperations:UnsupportedClass',...
            'Unsupported class ''%s'' passed; only strings are valid.',class(Level));
    end
    
    
    %   Get the stack.
    [Stack,~]    = dbstack('-completenames');
    
    % See if the stack is empty
    switch(length(Stack))
        
        %   An empty call stack implies a call from the command line, so return
        %   the current working directory with an appended separator.
        case 0
            TheCallerDirectory = [pwd(),filesep()];


        %   A call stack with 1 entry implies a call from a script with no function 
        %   nesting, so return the directory of the only entry with an appended 
        %   separator.
        case 1
             TheCallerDirectory = [SplitPath(Stack(1).file,'DirectoryPath'),filesep()];


        %   A call stack with more than 1 entry implies a call from a function with 
        %   atleast one nesting, so we'll attack this generally.
        otherwise
            CallersPath  = Stack(1).file;
            LineagePaths = {Stack(2:end).file};
            
            if (0 < DifferentNames) && not(isempty(LineagePaths))
                Paths    = unique(LineagePaths,'stable');
                Mask     = cumsum(not(strcmpi(CallersPath,Paths)));
                FullPath = Paths{find(Mask == DifferentNames,1,'first')};
                
                TheCallerDirectory = [SplitPath(FullPath,'DirectoryPath'),filesep()];
                
            else
                TheCallerDirectory = [CallersPath,filesep()];
            end
    end
    
end


