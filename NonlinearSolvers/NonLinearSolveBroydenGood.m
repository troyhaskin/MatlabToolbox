function [sol,varargout] = NonLinearSolveBroydenGood(xGuess,Residual,ResidualJacobian,varargin) %#ok<STOUT>
    
    xN         = xGuess                                        ;
    r          = @(x) Residual(x)                              ;
    Jac        = @(x) ResidualJacobian(x)                      ;
    iJacUpdate = @(iJ,dx,dr) (dx - iJ*dr)/(dx'*iJ*dr)*(dx'*iJ) ;
    
    Iter    = 0    	;
    rN      = r(xN)	;
    
    StopTol  = 100*eps()	;
    StopIter = 1E4          ;
    NotDone  = true         ;
    
    iJac     = inv(Jac(xN))  ;
   
    while NotDone
        
        xDelta  = -iJac*rN      ;
        xNp1    = xN + xDelta   ;
        
        rNp1    = r(xNp1)       ;
        rDelta  = rNp1 - rN     ;
        iJac    = iJac + iJacUpdate(iJac,xDelta,rDelta);
        
        xN      = xNp1     	;
        rN      = rNp1      ;
        Iter    = Iter + 1  ;
        
        NotConverged = norm(rN,1)  > StopTol            ;
        BelowIterMax = Iter     < StopIter             	;
        NotDone      = any(NotConverged & BelowIterMax)	;
        
    end
    
    sol = xN;
%     disp(['Iteraions: ',num2str(Iter)]);
%     disp('sol =');
%     disp(sol);
    
    if(not(BelowIterMax) && any(NotConverged))
        warning('Toolbox:TooManyIterations',...
               ['Solution did not converge with the specified tolerance in ',...
               num2str(Iter),' iterations; this may be avoided with better guess values']);
    end
end