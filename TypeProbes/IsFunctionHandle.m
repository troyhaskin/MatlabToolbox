function Logical = IsFunctionHandle(Object)
    
    if strcmpi(WhatIsThis(Object),'function_handle');
        Logical = true;
    else
        Logical = false;
    end
    
end