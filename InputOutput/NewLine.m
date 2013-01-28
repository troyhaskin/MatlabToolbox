function [] = NewLine(FileID)
    if     (nargin == 0)
        fprintf('\n');
        
    elseif (nargin == 1)
        fprintf(FileID,'\n');
        
    else
        error('MyMatlabToolbox:InputOutput:Newline',...
              'Too many input arguments passed to NewLine.m');
    end
end