function [] = SetInstalledVersionInformation(RSim)
    
    %   Find installed versions in the root by looking for 'r3d' in the directory
    %   names
    RSim.ValidVersionDirectoryNames = RSim.MatchNamesInDirectory(RSim.Root,'r3d');
    

    %   Get the version number (sans '.') from stripping 'r3d' and 'ie' from the
    %   directory names.
    UndottedVersionStrings = cellfun(...
                                @(c) strrep(strrep(c,'r3d',''),'ie','') ,...
                                RSim.ValidVersionDirectoryNames         ,...
                                'UniformOutput', false                  );


    %   Convert the undotted strings to doubles (actually uncasted integers) and assign.
    RSim.ValidVersionNumbers = str2double(UndottedVersionStrings);
    
    
    %   Inter-mixed the string version number with a '.' character and assign.
    RSim.ValidVersionStrings = cellfun(...
                                    @(c)  RSim.Interpose(num2str(c),'.') ,...
                                    UndottedVersionStrings          ,...
                                    'UniformOutput',false           );

end % SetInstalledVersionInformation