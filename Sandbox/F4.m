classdef F4
    
    properties
        A,B,C,D,E,F;
    end
    
    methods
    
        function Object = F4(A,B,C,D,E,F)
            Object.A = A;
            Object.B = B;
            Object.C = C;
            Object.D = D;
            Object.E = E;
            Object.F = F;
        end
        
        function b = run(Object,x,N)
            Alocal = Object.A;
            Blocal = Object.B;
            Clocal = Object.C;
            Dlocal = Object.D;
            Elocal = Object.E;
            Flocal = Object.F;
            
            for k = 1:N
                b = (Alocal*Blocal*Clocal*Dlocal*Elocal*Flocal)*x;
%                 b = (Object.A*Object.B*Object.C*Object.D*Object.E*Object.F)*x;
            end
        end
    
    end
    
    
end