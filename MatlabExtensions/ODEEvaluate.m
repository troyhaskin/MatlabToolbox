function yInt = ODEEvaluate(Solution,xInt)
    
    if not(isa(Solution,'struct'))
        error('MatlabToolbox:MatlabExtensions:ODEEvaluate:SolutionNotStruct',...
            'The first input must a solution struct from an ODE solver.');
    end
    
    if all(isfield(Solution,{'x','y','yp','solver'}))
        x      = Solution.x     ;
        y      = Solution.y     ;
        dy     = Solution.yp    ;
        Solver = Solution.solver;
    else
        error('MatlabToolbox:MatlabExtensions:ODEEvaluate:MissingSolutionFields',...
            'Solution struct must have ''x'', ''y'', ''yp'', and ''solver'' fields.');
    end
    
    
    if x(end) < x(1)
        x  = x(end:-1:1)    ;
        y  = y(:,end:-1:1)  ;
        dy = dy(:,end:-1:1) ;
    end
    
    
    IsInside        = (xInt >= x(1)) | (xInt <= x(end)) ;
    IsExact         = arrayfun(@(e) any(x == e),xInt)   ;
    WillInterpolate = IsInside & not(IsExact)           ;
    
    xWork = xInt(WillInterpolate);
    
    
    Ik    = arrayfun(@(elem)sum(x <= elem),xWork) + 1;
    xk    = x(Ik)       ;
    xkp1  = x(Ik + 1)   ;
    yk    = y (:,Ik)    ;
    ykp1  = y (:,Ik + 1);
    dyk   = dy(:,Ik)    ;
    dykp1 = dy(:,Ik + 1);
    
    yInt  = zeros(size(yk,1),length(xInt))  ;
    yWork = yInt(:,WillInterpolate)         ;
    
    
    Interpolate = @ntrp3h;
    
    for m = 1:size(y,1)
        yWork(m,:) = Interpolate(xWork,xk,xkp1,yk(m,:),ykp1(m,:),dyk(m,:),dykp1(m,:));
    end
    
    yInt(:,IsExact)         = y(:,IsExact)  ;
    yInt(:,WillInterpolate) = yWork         ;
    
    
    
end