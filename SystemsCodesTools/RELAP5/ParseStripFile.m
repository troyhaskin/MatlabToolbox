function [Data,varargout] = ParseStripFile(FileName)
    
    Fid         = fopen(FileName,'r');
    fgetl(Fid)                                  ;  % Line 1: STRIP meta-data
    RunName     = fgetl(Fid)                    ;  % Line 2: Run Name
    LineContent = fgetl(Fid)                    ;  % Line 3: Record Count
    Nrecords    = str2num(LineContent(12:end))  ;  %#ok<ST2NM>
    Nrecords    = Nrecords(1) - 1               ;  % one of the records is the "plotrec" identifier and not data
    NrecordsStr = num2str(Nrecords)             ;  % String version of Nrecords
    
    FileContent = fscanf(Fid,'%c')              ;  % Grab the entire file contents
    fclose(Fid);                                   % Release the file pointer
    
    
% Expression:       RecordID     Number Format    Padding     Number of Values    
    Expression  = ['plotrec\s+(\d\.\d+E[\+\-]\d+[\s\r\f\n]*){',NrecordsStr,'}'] ;

% Tokenize the file contents by "plotrec"
    Tokens      = regexp(FileContent,Expression,'tokens')                       ;
    

    Nsets       = length(Tokens)        ; % Number of strips requested from RELAP5 strip file
    Data        = zeros(Nsets,Nrecords) ; % Memory allocation
    
    
    for k = 1:Nsets
        StringData  = regexprep(char(Tokens{k}),'[\n\f\r]','')  ; % remove all newline characters from the token
        Data(k,:)   = str2num(StringData)                       ; %#ok<ST2NM> ; double2num does not support conversion to an array
    end
    
    if (nargout > 1)
        ExpressionType =  ['plotalf\s+(\S+[\s\r\f\n]+){',NrecordsStr,'}']   ;
        ExpressionIDs  =  ['plotnum\s+(\d+[\s\r\f\n]+){',NrecordsStr,'}']   ;
        TokensType     = regexp(FileContent,ExpressionType,'tokens')        ;
        TokensIDs      = regexp(FileContent,ExpressionIDs,'tokens')         ;
        
        RunInfo.RunName     = strtrim(RunName)                         ;  % the RELAP5 runname 
        RunInfo.EditName    = ExplodeString(char(TokensType{1}),' ')   ;  % the RELAP5 edit name for the information
        RunInfo.ComponentID = ExplodeString(char(TokensIDs{1}),' ')    ;  % the RELAP5 component ID for the information
        
        varargout{1} = RunInfo;
    end
    
end


function StrArray = ExplodeString(String,Delimiter)
    N           = length(String)        ;
    NotDone     = true                  ;
    Buffer      = cell(N+2,1)           ;
    Counter     = 0                     ;
    Bottom      = 1                     ;
    DelimStride = length(Delimiter) - 1 ;
    Top1        = 2                     ;
    Top2        = Top1 + DelimStride    ;
    
    if (~isempty(Delimiter) && (N > 0))
        while NotDone
            CurrentSet    = String(Top1:Top2)       ;
            CurrentString = strtrim(String(Bottom:(Top1-1)));
            
            if ((CurrentSet == Delimiter) && (~isempty(CurrentString)))
                Counter         = Counter + 1               ;
                Buffer{Counter} = CurrentString             ;
                Bottom          = Top2    + 1               ;
                Top1            = Bottom  + 1               ;
                Top2            = Top1    + DelimStride     ;
            else
                Top1            = Top1 + 1	;
                Top2            = Top2 + 1  ;
            end
            
            NotDone = Top1 < (N+1);
        end
        
        if (~isempty(String(Bottom:(Top1-1))))
            Counter         = Counter + 1               ;
            Buffer{Counter} = String(Bottom:(Top1-1))	;
        end
        
    else
        if (~isempty(String))
            Counter         = Counter + 1   ;
            Buffer{Counter} = String        ;
        end
    end
    
    StrArray = char(strtrim(Buffer(1:Counter)));
end

