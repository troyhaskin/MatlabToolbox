function [] = UpdateMatlabToolboxPath(toolboxDirectory,excludeTopDirectory)
    
    if (nargin ~= 1) || isempty(toolboxDirectory)
        toolboxDirectory = 'C:\Projects\MatlabToolbox';
    end
    
    if (nargin ~= 2) || isempty(excludeTopDirectory)
        excludeTopDirectory  = false;
    end
    
    updatePath(toolboxDirectory,excludeTopDirectory);
    
end