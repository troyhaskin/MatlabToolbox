function Interposed = Interpose(String,Interloper)
    
    Nstring    = length(String);
    
    
    Interposed(2 * Nstring - 1) = ' ';
    
    Interposed(1:2:end) = String;
    Interposed(2:2:end) = Interloper;
    
end % Interpose