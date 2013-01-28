function Series = CumulativeGeometricSeries(Scale,Ratio,Nterms)
% CumulativeGeometricSeries()
%   
%   A geometric sequence "G" with "n" terms, scale factor "a", and term ratio 
%   "r" has the form:
%       G = a {r^0 , r^1 , r^2 ,..., r^(n-1)}
%
%   This function returns a vector whose k-th element contains the sum of the
%   first k terms of a geometric series speficied by "Scale" and "Ratio" for
%   "Nterms":
%   
%   Series = Scale * [1 , 1+Ratio , 1+Ratio+Ratio^2 , ...];
%

    Series = ones(Nterms,1);
    
    for k = 2:Nterms
        Series(k) =  Series(k-1) + Ratio^(k-1);
    end
    
    Series = Scale * Series;

end