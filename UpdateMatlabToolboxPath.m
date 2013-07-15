function [] = UpdateMatlabToolboxPath(ToolboxDirectory)
    
if (nargin ~= 1) || isempty(Path)
    ToolboxDirectory = 'C:\Projects\MatlabToolbox';
end

% Setup exclusions
ExcludeTopDirectory  = false;
DirectoriesToExclude = {'.git','Hash/JavaScript','Sandbox'};
DirectoriesToExclude = DirectoriesToExclude(:);

% Generate the full toolbox path
ToolboxPath = genpath(ToolboxDirectory);

% Escape all backslashes
ToolboxPath               = strrep(ToolboxPath     ,'\','\\');
ToolboxDirectory          = strrep(ToolboxDirectory,'\','\\');

% Create regular expression for filtering excluded directories
ExclusionRegularExpression = strcat(ToolboxDirectory,'\\',...
                                    DirectoriesToExclude,'(\\ | ;)');

fprintf(strrep(strrep(ToolboxPath,'\','\\'),';',';\n'));

end
