classdef AugmentedProperty
    
    properties
        Value = [];
        IsSet = false;
    end
    
    methods
        function this = AugmentedProperty(Value,IsSet)
            if(nargin == 2)
                this.Value = Value;
                this.IsSet = IsSet;
            end
        end
    end
    
end