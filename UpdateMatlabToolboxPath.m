function [] = UpdateMatlabToolboxPath(ToolboxDirectory,ExcludeTopDirectory)
    
    if (nargin ~= 1) || isempty(ToolboxDirectory)
        ToolboxDirectory = 'C:\Projects\MatlabToolbox';
    end
    
    if (nargin ~= 2) || isempty(ExcludeTopDirectory)
        ExcludeTopDirectory  = false;
    end
    
    % Setup exclusions
    DirectoriesToExclude = {'.git','Hash','Sandbox'};
    DirectoriesToExclude = DirectoriesToExclude(:)' ;
    
    % Generate the full toolbox path
    ToolboxPath = genpath(ToolboxDirectory);
    
    % Escape all metacharacters (since these are used in expressions)
    DirectoriesToExclude = EscapeRegExMetacharacters(DirectoriesToExclude);
    ToolboxDirectory     = EscapeRegExMetacharacters(ToolboxDirectory);
    
    % Create regular expression for filtering excluded directories
    ExclusionRegEx= strcat(ToolboxDirectory,'\\'                    ,... % Top directory
                           '(',strjoin(DirectoriesToExclude,'|'),')',... % Exclusion grouping
                           '.*?;');                                      % Lazy wildcard grab
    
    % Remove all excluded directories
    PathToAdd = regexprep(ToolboxPath,ExclusionRegEx,'');
    
    % Remove top level directory if requested
    if ExcludeTopDirectory
        PathToAdd = regexprep(PathToAdd,[ToolboxDirectory,';'],'');
    end
    
    % Add  all included folders to the main search path
    addpath(PathToAdd);
    SaveOutcome = savepath();
    
    if (SaveOutcome == 0) 
        fprintf(strrep(strrep(PathToAdd,'\','\\'),';',';\n'));
        fprintf(['\n*** The above folders were successfully added and saved ',...
                 'to the MATLAB search path.***\n']);
    else
        fprintf(['\n*** The Toolbox paths were UNSUCCESSFULLY saved ',...
                 'to the MATLAB search path.\n***']);
    end
    
end

function EscapedString = EscapeRegExMetacharacters(String)
    
    EscapedString = String                          ;
    Escape        = @(c,Str) strrep(Str,c,['\',c])  ;
    
    EscapedString = Escape('\', EscapedString);
    EscapedString = Escape('^', EscapedString);
    EscapedString = Escape('$', EscapedString);
    EscapedString = Escape('.', EscapedString);
    EscapedString = Escape('|', EscapedString);
    EscapedString = Escape('?', EscapedString);
    EscapedString = Escape('*', EscapedString);
    EscapedString = Escape('+', EscapedString);
    EscapedString = Escape('-', EscapedString);
    EscapedString = Escape(':', EscapedString);
    EscapedString = Escape('(', EscapedString);
    EscapedString = Escape(')', EscapedString);
    EscapedString = Escape('[', EscapedString);
    EscapedString = Escape(']', EscapedString);
    EscapedString = Escape('{', EscapedString);
    EscapedString = Escape('}', EscapedString);
    
end
