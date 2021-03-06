function dydx = NPDiff(x,y,RowOrCol)
    
    if(nargin == 3)
        switch(lower(RowOrCol))
            case({'row','rows'})
%                 x = x;
%                 y = y;
                Finalize = @(z) z;
            case({'col','column','cols','columns'})
                x = x';
                y = y';
                Finalize = @(z) z';
            otherwise
        end
    else
        Finalize = @(z) z;
    end
    
    
    End  = size(x,2)    ;
    I    = 2:End-1      ;
    
    
    % ------------------------------------------------------------------------------
    %  Full Data Set:
    %  2nd order central difference on internal nodes and second order skewed
    %  forward on boundaries.
    if     (End > 3)
        dydx      = y                                          ; % Allocate dydx
        
        dydx(:,I)   = (y(:,I+1) - y(:,I-1)) ./ (x(:,I+1) - x(:,I-1) ); % 2nd order C.D.
        
        dydx(:,1)   = 0.5*( -3*y(:,1)  +    4*y(:,2)  -   y(:,3)   )./( x(:,2)  -   x(:,1)  );
        dydx(:,End) = 0.5*( y(:,End-2) - 4*y(:,End-1) + 3*y(:,End) )./(x(:,end) - x(:,end-1));
        
        
        % ------------------------------------------------------------------------------
        %  Two-Point Data Set:
        %  First order foward difference.
    elseif (End == 2)
        dydx = (y(:,2) - y(:,1)) ./ (x(:,2) - x(:,1) );
        
        
        % ----------------------------------------------------------------------
        %  Three-point Data Set:
        %  Second order central difference.
    elseif (End == 3)
        dydx = (y(:,3) - y(:,1)) ./ (x(:,3) - x(:,1));
        
        
    else
        error('Not enough points passed.')
    end
    
    
    dydx = Finalize(dydx);
    
end