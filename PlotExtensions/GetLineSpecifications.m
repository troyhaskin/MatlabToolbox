function LineSpec = GetLineSpecifications(Number)
    Colors   = {'m','k','b','r','g','c'}        ;
    Lines    = {':','-','--','-.'}              ;
    Markers  = {'h','','o','s','*','x','d','p'} ;
    
    Ncolor   = length(Colors)   ;
    Nline    = length(Lines)    ;
    Nmark    = length(Markers)  ;
    LineSpec = cell(Number,1)   ;
    
	LineCounter   = 1   ;
	MarkerCounter = 1   ;
    
    
    for k = 1:Number
        if(k > Ncolor)
            LineCounter = LineCounter + 1;
        end
        
        if(LineCounter > (Ncolor+Nline))
            MarkerCounter = MarkerCounter + 1;
        end
        
        Color   = Colors {mod(k,Ncolor)+1};
        Line    = Lines  {(mod(LineCounter,Nline )+1)};
        Marker  = Markers{mod(MarkerCounter,Nmark )+1};
        
        LineSpec{k} = [Color,Line,Marker];
    end
end