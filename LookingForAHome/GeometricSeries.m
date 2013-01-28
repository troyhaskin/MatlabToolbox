function Series = GeometricSeries(Scale,Ratio,Nterms)
% GeometricSeries()
%   
%   Returns a vector with each each element being a ter in a geometric series.
%   A geometric sequence "G" with "n" terms, scale factor "a", and term ratio 
%   "r" has the form:
%       G = a {r^0 , r^1 , r^2 ,..., r^(n-1)}
%
%   This function returns the above sequence in a vector for a geometric series 
%   speficied by "Scale" and "Ratio" for "Nterms".
%

    Series = ones(Nterms,1);
    
    for k = 2:Nterms
        Series(k) = Ratio * Series(k-1);
    end
    
    Series = Scale * Series;

end