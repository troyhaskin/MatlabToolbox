classdef ConstantAveragedPlotter < handle
    
    properties
        % Switches
        MarkPartitionCenters = true;
        MarkPartitionEdges   = false;
        
        
        % Styling
        Color           = [0,0,1]   ; % blue
        MarkerForEdges  = 'none'    ;
        MarkerForCenter = 'o'       ;
        LineStyle       = '-'       ;
        LineWidth       = 2;
        
        % Handles
        Figure = [] ;
        Axes   = [] ;
        
        % If a YDataFunction is defined, it will be plotted.
        PlotYDataFunction = true;
        FunctionPoints = 500;
        FunctionStyle = {'Color',[0,0,0],'LineStyle','-','LineWidth',2};
    end
    
    properties(SetAccess = private)
        % Data - Set this through the setPROPERTYNAME methods
        XData  = [] ;
        YData  = [] ;
        YDataFunction = []; % Function to get constant values from
        
        % Number of partitions
        PartitionCount = [];
        
        % Line plotting function
        PartitionPlotterCenter = [];
        PartitionPlotterEdges  = [];
        
        % Set variables
        IsSetXData    = false;
        IsSetYData    = false;
        IsSetYDataFunction = false;
        IsSetPlotters      = false;
    end
    
    
    methods
        
        % ==================================================================== %
        %                             Constructor                              %
        % ==================================================================== %
        function this = ConstantAveragedPlotter(x,y,AxesHandle)
            
            % If the data was assigned, assign it.
            if (nargin >= 2)
                
                this.setXData(x);
                this.setYData(y);
                
            end
            
            % If a handle was assigned, assign it.
            if (nargin == 3) && ishandle(AxesHandle)
                
                IsAnAxes = isfield(get(AxesHandle),'XLim'); % axes handles have the field 'XLim'
                
                switch(IsAnAxes)
                    case true
                        % Passed an axes handle
                        this.Axes   = AxesHandle;
                        this.Figure = get(AxesHandle,'Parent');
                    case false
                        % Passed a figure handle
                        this.Axes   = get(AxesHandle,'Children');
                        this.Figure = AxesHandle;
                end
            end
            
        end
        
        
        
        % ==================================================================== %
        %                          Plot style setter                           %
        % ==================================================================== %
        function [] = setPlotters(this,varargin)
            
            % For the main line (which includes the edges) ---------------------
            DefaultKeyValueList = {'Color'    ,this.Color           ,...
                                   'Marker'   ,this.MarkerForEdges  ,...
                                   'LineStyle',this.LineStyle       ,...
                                   'LineWidth',this.LineWidth       };
            KeyValueList = [DefaultKeyValueList,varargin];
            
            this.PartitionPlotterEdges = @(x,y) line('XData',x,'YData',y,KeyValueList{:});
            
            
            % For the center marker only ---------------------------------------
            DefaultKeyValueList = {'Color'    ,this.Color           ,...
                                   'Marker'   ,this.MarkerForCenter ,...
                                   'LineStyle','none'};
            KeyValueList = [DefaultKeyValueList,varargin];
            
            this.PartitionPlotterCenter = @(x,y) line('XData',x,'YData',y,KeyValueList{:});
            
            % Tell the object it's set
            this.IsSetPlotters = true;
        end
        
        
        
        % ==================================================================== %
        %                  XData set method for error catching                 %
        % ==================================================================== %
        function [] = setXData(this,x)
            
            if isnumeric(x) && isvector(x) && issorted(x)
                this.XData = x;
                this.PartitionCount = length(x) - 1;
                this.IsSetXData = true;
                
            else
                error('ConstantAveragedPlotter:BadXData',...
                    'The XData input must be a sorted, numeric vector.');
            end
            
        end
        
        
        % ==================================================================== %
        %                  YData set method for error catching                 %
        % ==================================================================== %
        function [] = setYData(this,y)
            
            if isnumeric(y) && isvector(y)
                this.YData = y;
                this.IsSetYData = true;
                
            elseif IsFunctionHandle(y)
                this.setYDataFunction(y);
                this.CalculateAvergeYValues();
                
            else
                error('ConstantAveragedPlotter:BadYData',...
                    'The YData input must be a sorted, numeric vector.');
            end
            
        end
        
        
        
        % ==================================================================== %
        %              YDataFunction set method for error catching             %
        % ==================================================================== %
        function [] = setYDataFunction(this,yFunction)
            
            if IsFunctionHandle(yFunction)
                this.YDataFunction = yFunction;
                this.IsSetYDataFunction = true;
                
            else
                error('ConstantAveragedPlotter:BadYDataFunction',...
                    'The YDataFunction input must be a function handle.');
            end
            
        end
        
        
        % ==================================================================== %
        %    Calculator for average y-values given a user-supplied function    %
        %       o varargin can be any valid parameter-value input for quadgk   %
        % ==================================================================== %
        function [] = CalculateAvergeYValues(this,varargin)
            
            if  (this.IsSetXData && this.IsSetYDataFunction)
                % Local variables
                myXData = this.XData;
                myYData = zeros(size(myXData)); % allocate memory
                
                % Integrate function over each partition and average
                for k = 1 : this.PartitionCount
                    Integral = quadgk(this.YDataFunction,myXData(k),myXData(k+1),varargin{:});
                    myYData(k) = Integral/(myXData(k+1)-myXData(k));
                end
                
                % Assign YData
                this.setYData(myYData);
                
            elseif not(this.IsSetXData)
                % No XData
                error('ConstantAveragedPlotter:XDataNotSet',...
                    ['Average y-values cannot be calculated because XData ',...
                    'has not been supplied. Assign Xdata by the setXData method.']);
            else
                % No functionhandle to integrate
                error('ConstantAveragedPlotter:YDataFUnctionNotSet',...
                    ['Average y-values cannot be calculated because no function ',...
                    'has been supplied. Assign a function handle by the setYDataFunction method.']);
            end
            
        end
        
        
        % ==================================================================== %
        %                          Plot renderer                               %
        % ==================================================================== %
        function [] = Render(this,varargin)
            
            if isempty(this.Figure)
                this.Figure = figure();
                this.Axes   = gca;
                
                set(this.Axes,'box','on','XGrid','on','YGrid','on');
            end
            
            
            if this.IsSetXData && this.IsSetYData
                
                if not(this.IsSetPlotters)
                    this.setPlotters(varargin{:});
                end

                % Local variables
                myXData = this.XData;
                myYData = this.YData;
                
                % Integrate function over each partition and average
                for k = 1 : this.PartitionCount
                    this.PartitionPlotterEdges(myXData(k:k+1),[myYData(k),myYData(k)]);
                    this.PartitionPlotterCenter(mean(myXData(k:k+1)),myYData(k));
                end
                
                if this.PlotYDataFunction
                    xPlot = linspace(myXData(1),myXData(end),this.FunctionPoints);
                    line(xPlot,this.YDataFunction(xPlot),this.FunctionStyle{:});
                end
                
            end

        end
        
        
    end
    
end


function Logical = IsFunctionHandle(Object)
    
    if strcmpi(WhatIsThis(Object),'function_handle');
        Logical = true;
    else
        Logical = false;
    end
    
end
