function color = GetColor(request)
    
    colors.black   = [0.0 , 0.0 , 0.0];
    colors.red     = [1.0 , 0.0 , 0.0];
    colors.green   = [0.0 , 0.6 , 0.0];
    colors.blue    = [0.0 , 0.0 , 1.0];
    colors.purple  = [0.6 , 0.0 , 0.6];
    colors.orange  = [1.0 , 0.5 , 0.0];
    colors.magenta = [1.0 , 0.0 , 1.0];
    colors.cyan    = [0.0 , 1.0 , 1.0];
    colors.grey    = [0.8 , 0.8 , 0.8];
    colors.yellow  = [1.0 , 1.0 , 0.0];
    colors.white   = [1.0 , 1.0 , 1.0];
    colors.gray    = colors.grey;
    
    
    if (ischar(request))
        if isfield(colors,lower(request))
            color = colors.(request);
        else
            error('The requested color ''%s'' could not be found',request);
        end
        
    elseif iscellstr(request)
        
        color = zeros(numel(request),3);
        for k = 1:numel(color)
            if isfield(colors,lower(request{k}))
                color(k,:) = colors.(request{k});
            end
        end
        
    else
        error('Expected string or a cell array of strings.');
    end
    
end

 