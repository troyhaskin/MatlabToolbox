function Color = GetColor(Request)
    
    if    (ischar(Request))
        Color = ColorLibraryCall(Request);
        
    elseif(isscalar(Request) || iscell(Request))
        Color = GetSetOfColors(Request);
        
    else
        error('Expected string or scalar input.');
    end
    
end



function List = GetDefaultColorFlow()
    List = { 'yellow','black','blue'   , 'red' , 'green','purple' ,...
        'orange', 'magenta', 'cyan'};
end



function Colors = GetSetOfColors(Request)
    if (isscalar(Request))
        List   = GetDefaultColorFlow();
        Colors = cell(Request,1);
        for k = 1:Request
            Colors{k} = ColorLibraryCall(List{mod(k,9)+1});
        end
    elseif(iscell(Request))
        List = Request;
        Colors = Request;
        for k = 1:length(Request)
            Colors{k} = ColorLibraryCall(List{mod(k,9)});
        end
    end
end



function Color = ColorLibraryCall(Request)
    switch (lower(Request))
        case('black')
            Color = [0.0, 0.0, 0.0];
        case('blue')
            Color = [0.0, 0.0, 1.0];
        case('red')
            Color = [1.0, 0.0, 0.0];
        case('purple')
            Color = [0.6, 0.0, 0.6];
        case('orange')
            Color = [1.0, 0.5, 0.0];
        case('green')
            Color = [0.0, 0.6, 0.0];
        case('magenta')
            Color = [1.0, 0.0, 1.0];
        case('cyan')
            Color = [0.0, 1.0, 1.0];
        case({'grey','gray'})
            Color = [0.8, 0.8, 0.8];
        case('yellow')
            Color = [1.0, 1.0, 0.0];
        case('white')
            Color = [1.0, 1.0, 1.0];
        otherwise
            error('Color request ''%s'' is not currently supported.',Request)
    end
end