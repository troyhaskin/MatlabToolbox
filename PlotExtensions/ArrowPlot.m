function Handle = ArrowPlot(x,y,dx,dy,varargin)

    % Columnify vectors
    x  = x(:)'  ;
    y  = y(:)'  ;
    dx = dx(:)' ;
    dy = dy(:)' ;

    % Create vectors for plotting the arrow shaft
    xEnd  = x + dx(:)'  ;
    yEnd  = y + dy(:)'  ;
    xPlot = [x ; xEnd]  ;
    yPlot = [y ; yEnd]  ;

    % Plot arrow shafts
    Lines = line(xPlot,yPlot,varargin{:});

    % Get angles of arrow pieces
    HeadTheta   = pi/6              ;
    ShaftTheta  = atan2(dy,dx)      ;

    % Get length of arrow pieces
    TotalLength = sqrt(dx.^2 + dy.^2)           ;
    HeadLength  = 0.1 * TotalLength             ;
    ShaftLength = TotalLength - HeadLength      ;
    BaseLength  = HeadLength * tan(HeadTheta)   ;

    % Get delta of arrow pieces
    dxShaft = ShaftLength .* cos(ShaftTheta);
    dyShaft = ShaftLength .* sin(ShaftTheta);
    dxBase  = BaseLength  .* sin(ShaftTheta);
    dyBase  = BaseLength  .* cos(ShaftTheta);

    % Create vectors for plotting the arrow heads
    xShaft = x + dxShaft;
    yShaft = y + dyShaft;
    xPlot  = [xEnd ; xShaft + dxBase];
    yPlot  = [yEnd ; yShaft - dyBase];

    % Plot one of the arrow heads' sides
    line(xPlot,yPlot,varargin{:});

    % Plot the other side of the head (this method preserves color order)
    xPlot  = [xEnd ; xShaft - dxBase];
    yPlot  = [yEnd ; yShaft + dyBase];
    line(xPlot,yPlot,varargin{:});
    
end