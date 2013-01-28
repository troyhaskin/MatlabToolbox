function Roots = FindLaguerrePRoots(l)
	
    
    if (l == 0)
        error('Laguerre Polynomial of degree 0 has no roots')                   ;
    elseif(l == 1)
        Roots = 1.0                                                             ;  % no work needed
        return                                                                  ;
    end
    
    LagP = @(x) GetLaguerreP(x,l);
    
%     Large           = @(N) 1.0 * 10^(N)                                         ;
%     N               = 8                                                         ;
%     InvLeadCoeff    = Large(N)^(l) / GetLaguerreP(Large(N),l)                   ;
%     
%     while (~isfinite(InvLeadCoeff))
%         N = N - 0.5                                                             ;
%         InvLeadCoeff    = Large(N)^(l) / GetLaguerreP(Large(N),l)               ;
%     end
%     
%     PolyHandle      = @(x) InvLeadCoeff * GetLaguerreP(x,l)                     ;
%     Roots           = RootFindDK(PolyHandle,l)                                  ; 
    
    
    
% 	if (l == 0)
% 		error('Laguerre Polynomial of degree 0 has no roots');
% 	elseif(l == 1)
% 		Roots = 1.0 ;  % no work needed
% 		return      ;
% 	end
% 	
% % ------------------------------------------------------------------------------
% %  Find guess roots on coarse mesh logically as follows:
% %
% %  1.) Apply a logic test for negative values
% %  2.) Add N points to N+1 points                  \  ( equivalent to XORing 
% %  3.) Locate the values of 1 to find coarse roots /    nearest neighbors )
% %
% %   Numerical Example:
% %     Data:	0.68	0.49	0.27	0.04	-0.19	-0.42	-0.62	-0.79   
% %   Step 1:   0       0       0      0         1       1       1      1
% %   Step 2:       0       0       0       1        2        2      2 
% %   Step 3:                               |  
% %                                   (guess root)
% %
% 	Nsteps			= 50E3                         ; % Coarse mesh steps
% 	Delta			= 50E3/(Nsteps-1)              ; % Coarse mesh spacing
% 	%CoarseMesh		= 0.0 : Delta : 50E3           ; % Coarse mesh
% 	CoarseMesh		= logspace(log10(1E-3),log10(1E3),Nsteps);% Coarse mesh
% 	Llvalues		= GetLaguerreP(CoarseMesh,l)   ; % L.P. values over mesh
% 	Negative		= Llvalues < 0                 ; % Logically mark negatives
% 	RightPts		= Negative(2:Nsteps)           ; % All but left boundary
% 	LeftPts			= Negative(1:Nsteps-1)         ; % All but right boundary
% 	GotRoot			= (RightPts + LeftPts) == 1    ; % Logically mark root
% 	CoarseRoots		= CoarseMesh(GotRoot)          ; % Coarse roots
% 	Nroots			= length(CoarseRoots)          ; % Count roots
%     Roots(Nroots)	= 0.0                          ; % Allocate for loop
% 
% % ------------------------------------------------------------------------------
% %  Find roots on fine mesh iteratively using linear interpolation between
% %  two bounding points about the guess root from above.
% %
% 	for k = 1:length(CoarseRoots)
% 		RootOld  = CoarseRoots(k); % Current root
% 		Root     = RootOld       ; % Current root guess
% 		Dx       = 0.1         ; % Initial spacing = top's mesh spacing
% 		NotFound = 1             ; % Enter iteration loop
% 		
% 		while(NotFound)
% 			X        = Root-Dx : 2*Dx : Root+Dx       ; % Straddle coarse root
% 			Llval    = GetLaguerreP(X,l)              ; % Get coarse-bound values
% 			Slope    =(X(2)-X(1))/(Llval(2)-Llval(1)) ; % Linear slope
% 			Root     = X(1) - Slope*Llval(1)          ; % New root from L.I.
% 			Error    = abs(Root - RootOld)            ; % Error change
% 			NotFound = Error > eps                    ; % Check for break
% 			Dx       = 0.1 * Dx                       ; % Shrink straddle
% 			RootOld  = Root                           ; % Update
% 		end
% 		Roots(k) = Root                               ; % Assign
% 	end
% 	
end