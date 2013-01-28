function Rounded = Round(Array,NearestDecimalPlace)
    
    if (nargin < 2)
        NearestDecimalPlace = 1;
    end
    
    Scale       = GetScale(NearestDecimalPlace) ;
    ScaledArray = Scale * Array                 ;
    Rounded     = round(ScaledArray) / Scale    ;
    
end

function Scale = GetScale(NearestDecimalPlace)
    switch(isnumeric(NearestDecimalPlace))
        case(true)
            Scale       = 10^NearestDecimalPlace    ;
        case(false)
            switch(strtrim(lower(NearestDecimalPlace)))
                case('tenth')
                    Scale       = 10^(1)  ;
                case('hundreth')
                    Scale       = 10^(2)  ;
                case('thousandth')
                    Scale       = 10^(3)  ;
                case('ten-thousandth')
                    Scale       = 10^(4)  ;
                otherwise
                    error('MatlabExtensions:Round:UnsupportedNearestOption',...
                        ['''%s'' is not a supported NearestDecimalPlace',...
                        ' option.'],NearestDecimalPlace);
            end
    end
end