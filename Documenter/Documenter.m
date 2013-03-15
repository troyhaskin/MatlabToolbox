function BaseName = Documenter(FileName,varargin)
    
    BaseName = GetBaseName(FileName);
    
    FileID = fopen('Test.txt','r');
    Line   = fgetl(FileID);
    
end

function Path = StripLeadingPath(Path)
    
    % This is a cell array of expressions to apply to the input $Path in order:
    %   1. Strip the drive letter (Windows)
    %   2. Strip leading \ or /
    %   3. Strip all <directory name>\ or <directory name>/ from the path.
    Expressions = {'^[a-zA-Z]*\:(\\|/)'   ,...
                   '^[\\/]*'         ,...
                   '^([\w\s]*(\\|/))+'};
    
    Path = regexprep(Path,Expressions,'');
end

function Path = StripFileExtenion(Path)
    
    % This is a cell array of expressions to apply to the input $Path in order:
    %   1. Strip .<anything> from the ending the of $Path.
    Expressions = '\..+$';
    
    Path = regexprep(Path,Expressions,'');
end

function Path = GetBaseName(Path)
    Path = StripLeadingPath(Path);
    Path = StripFileExtenion(Path);
end

function Html = CheckforOrderedList(Line)

    ListEntry = regexp(Line,'\s*\%\s*(\d)(\.)(.+)','tokens');
    
    if not(isempty(ListEntry))
    end

end
    
    
    
    
    