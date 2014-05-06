function [] = SetInstalledVersionInformation(RSim)
    DirectoryInfo       = dir(RSim.PathRoot)                ;
    DirectoryNames      = cell(1,length(DirectoryInfo))     ;
    [DirectoryNames{:}] = DirectoryInfo(:).name             ;
    IsRELAPDirectory    = cellfun( @(c) not(isempty(c))     ,...
        strfind(DirectoryNames,'r3d'))  ;
    
    % Assign discovered version directories to private variable
    RSim.ValidVersionDirectoryNames = DirectoryNames(IsRELAPDirectory);
    RSim.ValidVersionStrings        = RSim.GetVersionFromDirectoryName();
    RSim.ValidVersionNumbers        = str2double(strrep(...
        RSim.ValidVersionStrings,'.',''));

end % SetInstalledVersionInformation