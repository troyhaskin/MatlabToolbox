classdef Node < handle
    
    properties
        Name        = '';
        ID          = [];
        Value       = [];
        NeighborIDs = [];
        EdgeIDs     = [];
    end
    
    methods
        
        function NodeInstance = Node(n)
            
            if (nargin ~= 0) && isnumeric(n)
                if isscalar(n)
                    NodeInstance(n) = Node(); % Allocate object array
                else
                    n = mat2cell(n);
                    NodeInstance(n{:}) = Node(); % Allocate object array
                end
            end

        end
                
    end
    
end