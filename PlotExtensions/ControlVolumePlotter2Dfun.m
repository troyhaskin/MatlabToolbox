function Handle = ControlVolumePlotter2Dfun(x,y,Value)
    
    Handle = figure();
    hold('on');
    Ncv = length(Value);
    
    for k = 1:Ncv
        
        xMin = min(x{k});
        xMax = max(x{k});
        yMin = min(y{k});
        yMax = max(y{k});
        
        xPlot   = [xMin,xMax];
        yPlot   = [yMin,yMax];
        zPlot   = [1,1;1,1]*Value{k};
        
        [xPlot,yPlot] = meshgrid(xPlot,yPlot);
        
        surface(xPlot,yPlot,zPlot);
    end
    
end