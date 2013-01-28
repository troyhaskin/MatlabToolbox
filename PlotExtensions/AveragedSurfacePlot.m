function Handle = AveragedSurfacePlot(x,y,z,WeightFun)

    Handle = figure();
    hold('on');
    Limits = size(x);
    
    if(nargin < 4)
        WeightFun = @(x,y) ones(1,4);
    end
    
    if(numel(x) == numel(z))
        for k = 1:Limits(1)-1
            for m = 1:Limits(2)-1
                xPlot   = [x(k,m),x(k+1,m),x(k+1,m+1),x(k,m+1)]         ;
                yPlot   = [y(k,m),y(k+1,m),y(k+1,m+1),y(k,m+1)]         ;
                zPlot   = [z(k,m),z(k+1,m),z(k+1,m+1),z(k,m+1)]         ;
                Weights = WeightFun(xPlot,yPlot)                        ;
                zavg    = repmat(sum(Weights.*zPlot)./sum(Weights),2,2)	;

                [xPlot,yPlot] = meshgrid(xPlot([1,3]),yPlot([1,3]));
                surface(xPlot,yPlot,zavg);
            end
        end
    elseif((Limits(1)-1)*(Limits(2)-1) == numel(z))
        for k = 1:Limits(1)-1
            for m = 1:Limits(2)-1
                xPlot   = [x(k,m),x(k+1,m),x(k+1,m+1),x(k,m+1)]         ;
                yPlot   = [y(k,m),y(k+1,m),y(k+1,m+1),y(k,m+1)]         ;
                zavg    = repmat(z(k,m),2,2)                            ;

                [xPlot,yPlot] = meshgrid(xPlot([1,3]),yPlot([1,3]));
                surface(xPlot,yPlot,zavg);
            end
        end
    end
    
    hold('off');
    
end