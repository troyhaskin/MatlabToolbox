classdef ClosureClass
    
    properties
        A = magic(10);
        B
        C
        D
        E
        F
    end
    
    methods
        
        function Class = ClosureClass()
            Class.B = Class.A;
            Class.C = Class.A;
            Class.D = Class.A;
            Class.E = Class.A;
            Class.F = Class.A;
        end
        
        function b = fun(Obj,x)
            
            persistent A B C D E F
            
            if isempty(A)
                A = Obj.A;
                B = Obj.B;
                C = Obj.C;
                D = Obj.D;
                E = Obj.E;
                F = Obj.F;
            end
                b = (A*B*C*D*E*F)*x;
        end
        
        
        
    end
    
end