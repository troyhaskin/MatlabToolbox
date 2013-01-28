function Weights = FDCoefficients(Nderiv,Npoints,NaughtPoint)
    
    error(nargchk(1,3,nargin));
    
    if (nargin < 2)
        Npoints = Nderiv + 1;
    end
    
    if     ( (nargin < 3) && (mod(Npoints,2) ~= 0))
        NaughtPoint = (Npoints + 1) / 2 ;
    elseif (  nargin < 3                          )
        NaughtPoint = (Npoints + 2) / 2 ;
    end
    
    
    Nright      = Npoints - NaughtPoint         ;
    Nleft       = Npoints - Nright - 1          ;
    Dx          = -Nleft:1:Nright               ;
    TaylorCoeff = 1./factorial((1:Npoints))     ;
    
    CoeffMatrix = ones(Npoints);
    
    for k = 2:Npoints
        CoeffMatrix(k,:) = Dx.^(k-1) .* TaylorCoeff(k-1);
    end
    
    Solution            = zeros(Npoints,1)      ;
    Solution(Nderiv+1)  = 1                     ;
    
    RawWeights  = (CoeffMatrix \ Solution)';
    Weights     = FilterSmallReals(RawWeights,1E-12);
end