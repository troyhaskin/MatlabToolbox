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
    %               Determines how far up the stack to go before returning the directory.
    %               Therefore, this function deals with the depth of function nesting and 
    %               not number of different directories or different files.
    %           Default: 
    %               0 
    %           Values:
    %               -1 => This function   (CallerDirectory.m)
    %                0 => Caller
    %                1 => caller of Caller           ("parent")
    %                2 => caller of caller of Caller ("grandparent");
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
    [Stack,~] = dbstack('-completenames');
    Nstack    = length(Stack);

    %   One entry in the stack indicates this function was called from the command line.
    %   Current default behavior is to return Matlab's current working directory.
    if (Nstack > 1)
        if ((Level + 2) <= Nstack)
            TheCallerDirectory = [SplitPath(Stack(Level + 2).file,'DirectoryPath'),filesep()];
        else
            TheCallerDirectory = [SplitPath(Stack(end).file,'DirectoryPath'),filesep()];
        end
    else
        TheCallerDirectory = [pwd(),filesep()];
    end


end


