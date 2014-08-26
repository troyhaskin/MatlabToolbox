function VFcorrected = EnforceConsistency(VF,SA,RelTol,Norm)
    
    NotDone = true          ;
    Nvf     = length(VF)    ;
    Iter    = 0             ;
    
    if   (numel(SA) == 1)
        SA = ones(size(VF)) * SA;
    else (size(SA,1) == Nvf)
        SA = repmat(SA,1,Nvf);
    end
    
    if (nargin < 4)
        Norm = 1;
    end
    
    
    while NotDone
        
        % Generate Symmetrix Matrix from upper-triangular portion
        RecipMatrix     = VF .* SA                  ;
        U               = triu(RecipMatrix,1)      	;
        L               = U'                       	;
        D               = diag(diag(RecipMatrix))   ;
        RecipMatrix     = U + L + D                 ;
        VF_U            = RecipMatrix ./ SA         ;

        
        for k = 1:Nvf
            VF_U(k,:) = VF_U(k,:) ./ sum(VF_U(k,:));
        end
        
        % Generate Symmetrix Matrix from lower-triangular portion of corrected matrix
        RecipMatrix     = VF .* SA                  ;
        L               = tril(RecipMatrix,-1)  	;
        U               = L'                       	;
        D               = diag(diag(RecipMatrix))	;
        RecipMatrix     = U + L + D                 ;
        VF_L            = RecipMatrix ./ SA         ;

        for k = 1:Nvf
            VF_L(k,:) = VF_L(k,:) ./ sum(VF_L(k,:));
        end
        
        % Average the lower and upper view factor matrices together
        VF = (VF_L + VF_U)/2;
        
        % Perform iteration tests
        FailSum     = CheckSummation(VF,RelTol)             ;
        FailRecip   = CheckReciprocity(VF,SA,Norm,RelTol)   ;
        NotDone   	= FailRecip | FailSum                   ;
        
        Iter        = Iter + 1                              ;
    end
    
    VFcorrected = VF;
end



function FailSum = CheckSummation(VF,RelTolSum)
    FailSum = any(abs(1 - sum(VF,2))./sum(VF,2) > RelTolSum);
end

function FailRecip = CheckReciprocity(VF,SA,NormRecip,RelTolSum)
    SymmMat     = VF .* SA                          ;
    NormRez     = norm(SymmMat - SymmMat',NormRecip);
    NormSymm    = norm(SymmMat           ,NormRecip);
    FailRecip   = NormRez/NormSymm  > RelTolSum     ;
end