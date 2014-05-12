classdef Graph < handle % GraphAbstract
    
    properties
        Nodes
        Edges
    end
    
    properties( Hidden = true , Access = private )
        NodeCount = 0;
        EdgeCount = 0;
        
        ConstructorKeyPropertyMap = struct(...
            'NodeNames','Name','IDs')
    end
    
    methods

        function G = Graph(Nnodes,Nedges)
            
            %   Allocate the requested number of nodes
            if (nargin >= 1) && isnumeric(Nnodes) && isscalar(Nnodes)
                G.Nodes = Node();
                G.Nodes.Name        = repmat({''},Nnodes);
                G.Nodes.ID          = zeros(Nnodes,1);
                G.Nodes.Value       = cell(Nnodes,1);
                G.Nodes.NeighborIDs = repmat({[]},Nnodes,1);
                G.Nodes.EdgeIDs     = repmat({[]},Nnodes,1);
            end
            
            %   Allocate the requested number of edges
            if (nargin >= 2) && isnumeric(Nedges) && isscalar(Nedges)
                G.Edges = Edge();
                G.Edges.Name        = repmat({''},Nedges);
                G.Edges.ID          = zeros(Nedges,1);
                G.Edges.Value       = cell(Nedges,1);
                G.Edges.NeighborIDs = cell(Nedges,1);
                G.Edges.EdgeIDs     = cell(Nedges,1);
            end
            
        end

    end
    
    
    
end