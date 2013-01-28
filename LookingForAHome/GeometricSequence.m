function Sum = GeometricSequence(Scale,Ratio,Nterms)
% GeometricSequence()
%   
%   Returns a vector with each

    Sum = ones(Nterms,1);
    
    for k = 2:Nterms
        Sum(k) =  Sum(k-1) + Ratio^(k-1);
    end
    
    Sum = Scale * Sum;

end