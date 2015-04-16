function [] = updatePath(directory,excludeTopDirectory)
    
    if (nargin ~= 1) || isempty(directory)
        directory = pwd();
    end
    
    if (nargin ~= 2) || isempty(excludeTopDirectory)
        excludeTopDirectory  = false;
    end
    
    % Setup exclusions
    directoriesToExclude = {'.git','Sandbox','private'};
    directoriesToExclude = directoriesToExclude(:)' ;
    
    % Generate the full toolbox path
    path = genpath(directory);
    
    % Escape all metacharacters (since these are used in expressions)
    directoriesToExclude = escapeRegExMetacharacters(directoriesToExclude);
    directory            = escapeRegExMetacharacters(directory);
    
    % Create regular expression for filtering excluded directories
    exclusionRegEx= strcat(directory,'\\'                       ,... % Top directory
                           '(',stringJoin(directoriesToExclude,'|'),')',... % Exclusion grouping
                           '.*?;');                                         % Lazy wildcard grab
    
    % Remove all excluded directories
    pathToAdd = regexprep(path,exclusionRegEx,'');
    
    % Remove top level directory if requested
    if excludeTopDirectory
        pathToAdd = regexprep(pathToAdd,[directory,';'],'');
    end
    
    % Add  all included folders to the main search path
    addpath(pathToAdd);
    saveOutcome = savepath();
    
    if (saveOutcome == 0) 
        fprintf(strrep(strrep(pathToAdd,'\','\\'),';',';\n'));
        fprintf(['\n*** The above folders were successfully added and saved ',...
                 'to the MATLAB search path.***\n']);
    else
        fprintf(['\n*** The paths were UNSUCCESSFULLY saved ',...
                 'to the MATLAB search path.\n***']);
    end
    
end

function escapedString = escapeRegExMetacharacters(string)
    
    escapedString = string                          ;
    escape        = @(c,Str) strrep(Str,c,['\',c])  ;
    
    escapedString = escape('\', escapedString);
    escapedString = escape('^', escapedString);
    escapedString = escape('$', escapedString);
    escapedString = escape('.', escapedString);
    escapedString = escape('|', escapedString);
    escapedString = escape('?', escapedString);
    escapedString = escape('*', escapedString);
    escapedString = escape('+', escapedString);
    escapedString = escape('-', escapedString);
    escapedString = escape(':', escapedString);
    escapedString = escape('(', escapedString);
    escapedString = escape(')', escapedString);
    escapedString = escape('[', escapedString);
    escapedString = escape(']', escapedString);
    escapedString = escape('{', escapedString);
    escapedString = escape('}', escapedString);
    
end

function joined = stringJoin(string,joiner)
   if exist('strjoin','builtin') 
       joined = strjoin(string,joiner);
   else
       joined = [...
                cellfun(@(c) [c,'|'],string(1:end-1),'UniformOutput',false),...
                string(end)...
                ];
        joined = strcat(joined{:});
   end
end