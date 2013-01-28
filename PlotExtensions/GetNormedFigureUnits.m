function [Xnormed,Ynormed] = GetNormedFigureUnits(varargin)
    
    error(nargchk(2,3,length(varargin)));
    
    if ishandle(varargin{1})
        Handle = varargin{1};
        XData  = varargin{2};
        YData  = varargin{3};
    else
        Handle = gca;
        XData  = varargin{2};
        YData  = varargin{3};
    end
    

    % Axis normalized units
    FigureBox = get(Handle,'Position');
    XNormedStride = FigureBox(3);
    YNormedStride = FigureBox(4);
    
    % Data units
    XLimits = get(Handle,'XLim');
    YLimits = get(Handle,'YLim');
    XDataStride   = XLimits(2) - XLimits(1);
    YDataStride   = YLimits(2) - YLimits(1);
    
    % Data Conversion
    Xnormed = (XNormedStride/XDataStride)*(XData - XLimits(1)) + FigureBox(1);
    Ynormed = (YNormedStride/YDataStride)*(YData - YLimits(1)) + FigureBox(2);
    
end