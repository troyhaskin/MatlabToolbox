function E1 = ExponentialIntegral(x)
    
    xHi = x >  2.0  ;
	xLo = x <= 2.0  ;
    E1  = x         ;
    
% --------------------------------------------------------------------------
%   For small values we use a convergent series approximation 
%   (Abramowitz and Stegun)
%
    if (any(xLo))
        NotConverged = any(xLo)                       ;
		k            = 1                              ;
		xNow         = x(xLo)                         ;
		Value        = -EulerMascheroni() - log(xNow) ;
		SumTerm      = xNow                           ;
		kk           = 1:26                           ;
		C            = (kk-1) ./ kk.^2                ;
		
		while (NotConverged)
			OldValue     = Value                                   ;
			Value        = Value + SumTerm                         ;
			k            = k + 1                                   ;
			SumTerm      = - C(k) * xNow .* SumTerm                ;
			NotConverged = any(abs(Value - OldValue) > eps(Value)) ;
		end
		
		E1(xLo) = Value;
    end
 
% --------------------------------------------------------------------------
%   For large values, we use a Gauss-Laguerre quadrature rule
%
    if (any(xHi))
        xNow	= x(xHi)                        ;
        Length  = length(xNow)                  ;
        xp      = repmat(xNow(:),1,20)          ;
        Kernel  = @(t1,t2) exp(-t1) ./ (t2+t1)  ;
        
        [Nodes,Weights] = GetLocalLaguerreQuadratureSet()       ;
        Nodes           = repmat(Nodes  ,Length,1)              ;
        Weights         = repmat(Weights,Length,1)              ;
        E1temp          = sum(Kernel(xp,Nodes) .* Weights,2)    ;
        
        if (isequal(size(E1temp),size(xNow)))
            E1(xHi) = E1temp    ;
        else
            E1(xHi) = E1temp'   ;
        end
    end
    
    
% --------------------------------------------------------------------------
%   This older divergent series calculation was retired for the 
%   more vector-oriented (faster) Gauss-Laguerre quadrature rule.  Although
%   this method does have less memory usage than the new method.
%
% % % --------------------------------------------------------------------------
% % %   For large values we use a divergent series approximation
% % %    
% %     if (any(xHi))
% % 		k            = 1            ;
% % 		Value        = 1.0          ;
% % 		xNow         = x(xHi)       ;
% % 		ixNow        = 1 ./ (-xNow) ;
% % 		SumTerm      = ixNow        ;
% % 		
% % 		while (k < 11)
% % 			Value        = Value + SumTerm                             ;
% % 			k            = k + 1                                       ;
% % 			SumTerm      = k * ixNow .* SumTerm                        ;
% % 		end
% % 		
% % 		E1(xHi) = exp(-xNow) .* Value ./ xNow;
% % 	end
    
    function [N,W] = GetLocalLaguerreQuadratureSet()
        
        N   =   [0.0705398896919888, 0.372126818001611, 0.916582102483274   ,...
            1.70730653102834   , 2.74919925530943 , 4.04892531385089        ,...
            5.61517497086162   , 7.45901745367106 , 9.59439286958110        ,...
            12.0388025469643   , 14.8142934426307 , 17.9488955205194        ,...
            21.4787882402850   , 25.4517027931869 , 29.9325546317006        ,...
            35.0134342404790   , 40.8330570567286 , 47.6199940473465        ,...
            55.8107957500639   , 66.5244165256158                           ];
        
        W =   [0.16874680        , 0.29125436       , 0.26668610            ,...
            0.166002453        , 0.0748260647     , 0.02496441731           ,...
            0.006202550845     , 0.0011449623865  , 0.00015574177303        ,...
            0.0000154014408652 , 1.08648636652E-6 , 5.33012090956E-8        ,...
            1.75798117905E-9   , 3.72550240251E-11, 4.767529251578E-13      ,...
            3.37284424336E-15  , 1.15501433950E-17, 1.539522140582E-20      ,...
            5.28644272557E-24  , 1.65645661249E-28                          ];
    end
end