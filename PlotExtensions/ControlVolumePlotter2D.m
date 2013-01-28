classdef ControlVolumePlotter2D < handle
    
    properties
        foo = AugmentedProperty([],false);
    end
    
    methods
        
        function this = ControlVolumePlotter2D()
        end
        
        function [] = set.foo(this,Value)
            if isnumeric(Value)
                this.foo.Value = Value;
                this.foo.IsSet = true;
            end
        end
        
        function Value = get.foo(this)
            Value = this.foo.Value;
        end
        
        function [] = dispfoo()
            disp(this.foo.Value);
        end
        
    end
    
    
end