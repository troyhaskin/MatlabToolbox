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