function TheCallerDirectory = CallerDirectory(Level)
    
    %   For this file, Caller refers to the function that calls this function;
    %   the Caller is the function that wants its caller's directory.
    %
    %   Stack Level explanation:
    %       1 = This function   (CallerDirectory.m)
    %       2 = Caller function (The function that wants its caller's directory)
    %       3 = Parent of Caller
    %       4 = Grandparent of Caller
    %
    %   Therefore, if the first two levels are omitted from the dbstack() call below,
    %   then the Caller's parent's information is in the first index of each field in
    %   the return struct.
    
    
    
    % Simple processing for the Level options
    if (nargin == 0) || isempty(Level)
        DifferentNames = 1;
        
    elseif ischar(Level)
        switch(lower(Level))
            case('parent')
                DifferentNames = 1;
                
            case('grandparent')
                DifferentNames = 2;
                
            case('caller')
                DifferentNames = 0;
                
            otherwise
                error('MatlabToolBox:FileOperations:UnsupportedLevel',...
                    'Unknown level option ''%s'' passed.',Level);
        end
    else
        error('MatlabToolBox:FileOperations:UnsupportedClass',...
            'Unsupported class ''%s'' passed; only strings are valid.',class(Level));
    end
    
    
    %   Get the stack.
    [Stack,~]    = dbstack(1,'-completenames');
    
    % See if the stack is empty
    switch(length(Stack))
        
        %   An empy call stack implies a call from the command line, so return
        %   the current working directory with an appended separator.
        case 0
            TheCallerDirectory = [pwd(),filesep()];


        %   A call stack with 1 entry implies a call from a script with no function 
        %   nesting, so return the working directory of the only entry with an appended 
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


