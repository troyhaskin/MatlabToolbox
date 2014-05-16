function MatchedNames = MatchNamesInDirectory(Directory,Pattern)
    
    %   Query the Fluid Property location
    DirectoryInfo = dir(Directory);
    
    %   Allocate a name cell array for later assignment
    DirectoryNames = cell(1,length(DirectoryInfo))     ;
    
    %   Pull all of the names from the struct returned by dir()
    [DirectoryNames{:}] = DirectoryInfo(:).name             ;
    
    %   Create a logical mask by applying Pattern via strfind() to each
    %   element of the cell array
    IsMatch = cellfun(  @(c) not(isempty(c)) , strfind(DirectoryNames,Pattern))  ;
    
    %   Pull the matched names by applying the logical mask to the name cell array
    MatchedNames = DirectoryNames(IsMatch);
    
end % MatchNamesInDirectory