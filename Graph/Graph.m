classdef Graph < handle % GraphAbstract
    
    properties
        Nodes
        Edges
    end
    
    methods

        function G = Graph(Nnodes,Nedges)
            
            if (nargin >= 1) && isnumeric(Nnodes) && isscalar(Nnodes)
                G.Nodes = Node(Nnodes);
            end
            
            if (nargin >= 2) && isnumeric(Nedges) && isscalar(Nedges)
                G.Edges = Edge(Nedges);
            end
            
        end

    end
    
    
    
end