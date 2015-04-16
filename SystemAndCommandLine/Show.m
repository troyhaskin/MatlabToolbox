function [] = Show(n,Format)
    
    if (nargin < 2)
        Format      = '%+23.16E'   ;
    end
    Expansion	= ['\t',Format] ;
    
    if (size(n,1) > 1)
        Format = [Format,repmat(Expansion,1,size(n,1)-1),'\n'];
    else
        Format = [Format,'\n'];
    end
    
    fprintf(Format,n)  ;
end