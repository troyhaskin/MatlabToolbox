function Unique = AllVectorUniques(Vector,Tolerance)
    
    error(nargchk(1,2,nargin));
    
    Unique  = Vector                    ;
    k       = 1                         ;
    
    switch(nargin)
        case(1)
            while any(Vector)
                Unique(k)   = Vector(1)                     ;
                Vector      = Vector(Vector ~= Unique(k))	;
                k           = k + 1                         ;
            end
            
            
        case(2)
            while any(Vector)
                Unique(k)   = Vector(1)                         ;
                Mask        = abs(Vector-Unique(k)) > Tolerance ;
                Vector      = Vector(Mask)                      ;
                k           = k + 1                             ;
            end
    end
    
    Unique = Unique(1:k-1);
    
end