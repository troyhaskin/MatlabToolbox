function Logical = IsFunctionHandle(Object)
    
    if isa(Object,'function_handle');
        Logical = true;
    else
        Logical = false;
    end
    
end