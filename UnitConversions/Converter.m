function Quantity = Converter(Quantity,UnitFrom,UnitTo)
    
    UnitFrom = ConversionConstant(UnitFrom);
    UnitTo   = ConversionConstant(UnitTo);
    
    Quantity = Quantity * UnitTo/UnitFrom;
    
end

function Unity = ConversionConstant(Unit)
    
    switch(lower(Unit))
        % 
        %  SI Conversions.
        case('m')
            Unity = 1E0; %[m/m]
        case('dm')
            Unity = 1E1; %[dm/m]
        case('cm')
            Unity = 1E2; %[cm/m]
        case('mm')
            Unity = 1E3; %[mm/m]
        case({'mum','um','micron'})
            Unity = 1E6; %[mum/m]
        case('nm')
            Unity = 1E9; %[nm/m]
            
            
        % 
        %  U.S.A. Customary Conversions.
        case('in')
            Unity = 39.3701; %[in/m]
    end
end

