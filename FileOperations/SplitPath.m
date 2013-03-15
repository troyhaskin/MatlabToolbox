function TheSplitPath = SplitPath(Path,DesiredPiece)
    
    [DirectoryPath,FileName,Extension] = fileparts(Path);
    
    if (nargin < 2)
        TheSplitPath.DirectoryPath = DirectoryPath;
        TheSplitPath.BaseName      = [FileName,Extension];
        TheSplitPath.FileName      = FileName;
        TheSplitPath.Extension     = Extension;
        
    else
        if any(strcmpi('DirectoryPath',DesiredPiece))
            TheSplitPath = DirectoryPath;
        end
        
        if any(strcmpi('BaseName',DesiredPiece))
            TheSplitPath = [FileName,Extension];
        end
        
        if any(strcmpi('FileName',DesiredPiece))
            TheSplitPath = FileName;
        end
        
        if any(strcmpi('Extension',DesiredPiece))
            TheSplitPath = Extension;
        end
    end



        % ================================================================ %
        %              Personal, RegEx version of fileparts.m              %
        % ================================================================ %
    %
    %         %               Input checking
    %         % ==========================================
    %
    %         ValidPieces = {'All','DirectoryPath','BaseName','FileName','Extension'};
    %
    %         % Default
    %         if (nargin < 2)
    %             DesiredPiece = 'All';
    %
    %             % Make sure it is a string
    %         elseif not(ischar(DesiredPiece))
    %             error('MatlabToolbox:SplitPath:NonStringPathPiece'                          ,...
    %                 ['Unrecognized or unsupported class ''%s'' given for DesiredPiece. '  ,...
    %                 'The only valid class is string.'], class(DesiredPiece)               );
    %
    %             % Make sure it is a valid piece request
    %         elseif not(any(strcmpi(DesiredPiece,ValidPieces)))
    %             error('MatlabToolbox:SplitPath:InvalidPathPiece'                        ,...
    %                 ['Unrecognized or unsupported path piece ''%s'' given. '          ,...
    %                 'Valid path pieces are: All, DirectoryPath, BaseName, FileName, ' ,...
    %                 'and Extension.'], DesiredPiece                                   );
    %
    %         end
    %
    %
    %         % Windows-based RegExs for a path
    %         if ispc
    %             PathStart        = '^([A-Za-z]\:\\|\\{2})?' ;
    %             PathDirectories  = '(?:.+\\)*'              ;
    %             BaseName         = '(.+)'                   ;
    %             BaseNameSplitter = '^(.+)(\.)(.*?)$'        ;
    %         end
    %
    %
    %         % Split the path between the directory hierarchy and the basename
    %         Tokens = regexp(Path,['^(',PathStart,PathDirectories,')',BaseName,'$'],'tokens');
    %         Tokens = Tokens{1};
    %
    %         % If a basename has been found, perform extra splitting if requested
    %         if not(isempty(Tokens)) && any(strcmpi(DesiredPiece,{'All','FileName','Extension'}))
    %
    %             BaseName = Tokens{2};
    %
    %             % If there is an extension separator (i.e., "."), use the BaseNameSplitter
    %             if not(isempty(strfind(BaseName,'.')))
    %                 Temp   = regexp(BaseName,BaseNameSplitter,'tokens');
    %                 Tokens = [Tokens,Temp{1}];
    %
    %                 % Otherwise, the basename is just the FileName
    %             else
    %                 Tokens = [Tokens,{BaseName,'',''}];
    %             end
    %         end
    %
    %
    %         if not(isempty(Tokens))
    %
    %
    %             if any(strcmpi('All',DesiredPiece))
    %                 TheSplitPath.DirectoryPath = Tokens{1};
    %                 TheSplitPath.BaseName      = Tokens{2};
    %                 TheSplitPath.FileName      = Tokens{3};
    %                 TheSplitPath.Extension     = Tokens{5};
    %
    %             else
    %                 if any(strcmpi('DirectoryPath',DesiredPiece))
    %                     TheSplitPath = Tokens{1};
    %                 end
    %
    %                 if any(strcmpi('BaseName',DesiredPiece))
    %                     TheSplitPath = Tokens{2};
    %                 end
    %
    %                 if any(strcmpi('FileName',DesiredPiece))
    %                     TheSplitPath = Tokens{3};
    %                 end
    %
    %                 if any(strcmpi('Extension',DesiredPiece))
    %                     TheSplitPath = Tokens{5};
    %                 end
    %             end
    %         else
    %             TheSplitPath = false();
    %         end
end


