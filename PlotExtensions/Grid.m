function [] = Grid(GridOption1,GridOption2)

error(nargchk(1, 3, nargin))
% Define Color and Style defaults
GridColorDefault = [0.85,0.85,0.85];
GridStyleDefault = '-';

% ------------------------------------------------------------------- %
%                      Input Processing                               %
% ------------------------------------------------------------------- %
if     (nargin < 2)                     % Only axes handle is given.
    GridStyle = GridStyleDefault;
    GridColor = GridColorDefault;
elseif (nargin < 3)                     % One option is input.
    if (ischar(GridOption1))            % A string flags style input.
        GridStyle = GridOption1;
        GridColor = GridColorDefault;
    else                                % A non-string flags color input.
        GridStyle = GridStyleDefault;
        GridColor = GridOption1;
    end
else                                    % Two options are input.
    if (ischar(GridOption1))            % A string flags style input.
        GridStyle = GridOption1;
        GridColor = GridOption2;
    else                                % A non-string flags color input.
        GridStyle = GridOption2;
        GridColor = GridOption1;
    end
end

% ------------------------------------------------------------------- %
%                    Grab Gridline Parameters                         %
% ------------------------------------------------------------------- %
XTickPos = get(gca,'XTick')'; % Vertical line positions.
YTickPos = get(gca,'YTick')'; % Horizontal line positions.
Xlimits  = get(gca,'XLim');   % X-axis Limits.
Ylimits  = get(gca,'YLim');   % Y-axis Limits.
Xcolor   = get(gca,'XColor'); % X-axis Colors.
Ycolor   = get(gca,'YColor'); % Y-axis Colors.
% ------------------------------------------------------------------- %
%                    Grab Re-Plot Parameters                          %
% ------------------------------------------------------------------- %
ChldHand = get(gca,'Children');             % Axis handle.
Xvals    = get(ChldHand,'XData');           % Get plot data
Yvals    = get(ChldHand,'YData');           %      for re-plotting.
Style    = get(ChldHand,'LineStyle');       % Get user-defined
Width    = get(ChldHand,'LineWidth');       %      line width, style,
Color    = get(ChldHand,'Color');           %      color, and marker.
Mrkr     = get(ChldHand,'Marker');          %
MrkrEC   = get(ChldHand,'MarkerEdgeColor'); % Get user-defined 
MrkrFC   = get(ChldHand,'MarkerFaceColor'); %      marker properties.
MrkrSz   = get(ChldHand,'MarkerSize');      % 


% ------------------------------------------------------------------- %
%                          Gridline Setup                             %
% ------------------------------------------------------------------- %
H_fig     = Ylimits(2)-Ylimits(1);
W_fig     = Xlimits(2)-Xlimits(1);
VertLines = [Ylimits(1)+0.01*H_fig;Ylimits(2)];
HorzLines = [Xlimits(1)+0.01*W_fig;Xlimits(2)];

Xpos      = [XTickPos(2:end-1),XTickPos(2:end-1)];
Xbegin    = [XTickPos(1),XTickPos(1)];
Xend      = [XTickPos(end),XTickPos(end)]+0.01*W_fig;

Ypos      = [YTickPos(2:end-1),YTickPos(2:end-1)];
Ybegin    = [YTickPos(1),YTickPos(1)];
Yend      = [YTickPos(end),YTickPos(end)];

% Clear figure and re-plot so grid lines are underneath
cla(gca);

% ------------------------------------------------------------------- %
%                          Gridline Plot                              %
% ------------------------------------------------------------------- %
hold on
% ----- Plot Middle Bars ----- %
f     = plot(Xpos,VertLines);
g     = plot(HorzLines,Ypos);
set([f;g],'Color',GridColor,'LineStyle',GridStyle)

% ----- Plot Border Bars ----- %
% k = plot(Xbegin,VertLines);
l = plot(Xend,VertLines);
set(l,'Color',Xcolor)
% m = plot(HorzLines,Ybegin);
 n = plot(HorzLines,Yend);
 set(n,'Color',Ycolor)


% ------ Remove Gridlines from legend ----- %
Combo = [f;g];%k;l;m;n];
for i = 1:length(Combo)
    GridHandle = get(Combo(i),'Annotation');
    set(get(GridHandle,'LegendInformation'),'IconDisplayStyle','off');
end


% ------------------------------------------------------------------- %
%                               Re-Plot                               %
% ------------------------------------------------------------------- %
if (iscell(Xvals))
    for plot_n = 1:size(Xvals,1);
        PlotX    = cell2mat(Xvals(plot_n));
        PlotY    = cell2mat(Yvals(plot_n));
        Style_n  = cell2mat(Style(plot_n));
        Width_n  = cell2mat(Width(plot_n));
        Color_n  = cell2mat(Color(plot_n));
        Mrkr_n   = cell2mat(Mrkr(plot_n));
        MrkrEC_n = cell2mat(MrkrEC(plot_n));
        MrkrFC_n = cell2mat(MrkrFC(plot_n));
        MrkrSz_n = cell2mat(MrkrSz(plot_n));
        h        = plot(PlotX,PlotY);
        set(h,'LineStyle',Style_n,'Color',Color_n,'LineWidth',Width_n);
        set(h,'Marker',Mrkr_n,'MarkerEdgeColor',MrkrEC_n)
        set(h,'MarkerFaceColor',MrkrFC_n,'MarkerSize',MrkrSz_n)
    end
else
    h = plot(Xvals,Yvals);
    set(h,'LineStyle',Style,'Color',Color,'LineWidth',Width);
    set(h,'Marker',Mrkr,'MarkerEdgeColor',MrkrEC)
    set(h,'MarkerFaceColor',MrkrFC,'MarkerSize',MrkrSz)
end

axis([Xlimits(1) Xlimits(2) Ylimits(1) Ylimits(2)])
hold off


end