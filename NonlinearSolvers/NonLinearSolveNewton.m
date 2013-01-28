function [sol,varargout] = NonLinearSolveNewton(xGuess,Residual,ResidualJacobian,StopTol,varargin)
    
    xN  = xGuess                    ;
    r   = @(x) Residual(x)          ;
    Jac = @(x) ResidualJacobian(x)  ;
    
    Iter    = 0     ;
    rN      = r(xN) ;
    
    if (nargin < 4)
        StopTol  = 1000*eps()	;
    end
    
    StopIter = 1E3          ;
    NotDone  = true         ;
    p        = 1            ;
    xBest    = xGuess       ;
    rBest    = norm(rN,p)   ;
	Cond     = Inf          ;
    LimitLo  = [0;0;0];
    LimitHi  = [1;1;1];
    
%     try
% figure(1);hold('on');
        while NotDone
%             plot(Iter,xN(1),'bo','MarkerFaceColor','b');
%             plot(Iter,xN(2),'ro','MarkerFaceColor','r');
%             plot(Iter,xN(3),'ko','MarkerFaceColor','k');
%             axis([0,Iter+1,0,2]);
            xDelta  = -Jac(xN) \ rN	;
            xNp1    = xN + xDelta   ;
            
                    Cond = min(Cond,cond(Jac(xN)));
            
            rNp1    = r(xNp1)    	;
%               disp(norm(rNp1));
            rN      = rNp1;
            xN      = max(xNp1;
            Iter    = Iter + 1	;
            
            rNnorm       = norm(rN,p)                      	;
            NotConverged = (rNnorm > StopTol)               ;
            BelowIterMax = Iter       < StopIter           	;
            NotDone      = any(NotConverged & BelowIterMax) ;
            
            if (rNnorm < rBest) && all(isfinite(xN) & isreal(xN))
                xBest = xN;
                rBest = rNnorm;
            end
            
            if isnan(rNnorm) || any(isnan(xN) | not(isreal(xN)))
                NotConverged = true;
                break;
            end
            
        end
%         clf;
%     catch Error %#ok<NASGU>
%         xN = NaN;
%     end
    
        fprintf('\nFinal L_1 is %10E in %4G iterations with minimum condition %10E.',rBest,Iter,Cond);
    %     sol = xN;
    %     disp(['Iteraions: ',num2str(Iter)]);
    %     disp('sol =');
    %     disp(sol);
    
    %     if(not(BelowIterMax) && any(NotConverged))
    %         warning('Toolbox:TooManyIterations',...
    %                ['Solution did not converge with the specified tolerance in ',...
    %                num2str(Iter),' iterations; this may be avoided with better guess values']);
    %     end
    Converged = not(NotConverged);
    
    switch(Converged)
        case true
            
            sol = xN;
            
            if (nargout > 1)
                varargout{1} = true; % No error.
            end
            
        case false
            
            if isnan(rNnorm) || (rBest < rNnorm)
                sol = xBest;
            elseif all(isfinite(xN))
                sol = xN;
            else
                sol = NaN;
            end           
            
            if (nargout > 1)
                varargout{1} = false; % error.
            end
    end
end