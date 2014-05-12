classdef Edge < handle
    
    properties
        Name          = '';
        ID            = [];
        Value         = [];
        ConnectionIDs = [];
    end
    
    
    methods

        function EdgeInstance = Edge(n)
            
            if (nargin ~= 0) && isnumeric(n)
                if isscalar(n)
                    EdgeInstance(n) = Edge(); % Allocate object array
                else
                    n = mat2cell(n);
                    EdgeInstance(n{:}) = Edge(); % Allocate object array
                end
            end

        end

    end
    
    
end