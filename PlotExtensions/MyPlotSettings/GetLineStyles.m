function LineStyle = GetLineStyles(NumberOfPlots)
    
    ColorSpecifier = {'k','b','r','g','c','m'};
    LineSpecifier  = {' -','--',' :','-.'};
    LineStyle      = cell(NumberOfPlots,1);
    M              = length(ColorSpecifier);
    N              = length(LineSpecifier);
    m              = 1;
    n              = 1;
    
    if (NumberOfPlots > 24)
        warning('MyToolBox:PlotExtensions:TooManyStyle'                        ,...
               ['GetLineStyles can only produce 24 unique styles; the returned',...
                 ' style list has duplicate styles at the end'                 ]);
    end
    
    for k = 1:NumberOfPlots
        LineStyle{k} = deblank(strcat(LineSpecifier{n},ColorSpecifier{m}));
        
        ResetColorCount    = (m == M);
        
        if (~ResetColorCount)
            m = m + 1;
        else
            m = 1;
        end
        
        if (ResetColorCount)
            n = n + 1;
        end
        
        if (n > N)
            n = 1;
        end
    end
    
end