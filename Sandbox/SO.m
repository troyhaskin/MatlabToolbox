allowed = [0, 25, 240];
v = [0, 25, 240, NaN, 0, 25, 240, NaN]';

% Error check
notAllowed = not(any(bsxfun(@eq,v,allowed),2));
notNaN     = not(isnan(v));
if any(notAllowed & notNaN)
    error('Illegal entry');
end

% Perform mapping
v( v == 0   ) = 1;
v( v == 25  ) = 2;
v( v == 240 ) = 9;
v( isnan(v) ) = 0;

v