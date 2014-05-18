classdef Graph < handle % GraphAbstract
    
    properties
        Nodes
        Edges
    end
    
    properties( Hidden = true , Access = private )
        NodeCount = 0;
        EdgeCount = 0;
        
        ConstructorKeyPropertyMap = struct(...
            'NodeNames', {}, 'NodeIDs', [], 'NodeValues', {},...
            'EdgeNames', {}, 'EdgeIDs', [], 'EdgeValues', {});
    end
    
    methods

        function G = Graph(Nnodes,Nedges,varargin)
            
            %
            %   Allocate the requested number of nodes
            %
            if (nargin >= 1)     && isnumeric(Nnodes)    && ...
                isscalar(Nnodes) && not(isempty(Nnodes))
                G.Nodes = Node();
                G.Nodes.Name        = repmat({''},Nnodes);
                G.Nodes.ID          = zeros(Nnodes,1);
                G.Nodes.Value       = cell(Nnodes,1);
                G.Nodes.NeighborIDs = repmat({[]},Nnodes,1);
                G.Nodes.EdgeIDs     = repmat({[]},Nnodes,1);
            end
            
            
            %
            %   Allocate the requested number of edges
            %
            if (nargin >= 2)     && isnumeric(Nedges)    && ...
                isscalar(Nnodes) && not(isempty(Nnodes))
                G.Edges = Edge();
                G.Edges.Name        = repmat({''},Nedges);
                G.Edges.ID          = zeros(Nedges,1);
                G.Edges.Value       = cell(Nedges,1);
                G.Edges.NeighborIDs = cell(Nedges,1);
                G.Edges.EdgeIDs     = cell(Nedges,1);
            end


            %
            %   Handle key-value inputs
            %
            if length(varargin) >= 2
                
                %
                %   Pull key-value pairs
                %
                Keys   = varargin(1:2:end);
                Values = varargin(2:2:end);
                
                
                %
                %   Determine if the keys meet one criterion of validity
                %
                IsNodeKey = cellfun(...
                    @(c) not(isempty(strfind(c,'Node'))), Keys);
                IsEdgeKey = cellfun(...
                    @(c) not(isempty(strfind(c,'Edge'))), Keys);
                Keys   = [Keys(IsNodeKey)  , Keys(IsEdgeKey)  ];
                Values = [Values(IsNodeKey), Values(IsEdgeKey)];


                %
                %   Number of node/edge/values
                %
                NnodeKeys = nnz(IsNodeKey);
                NedgeKeys = nnz(IsEdgeKey);


                %
                %   Create handle for determining valid sub-names
                IsValidSubname = @(k) ...
                    not(isempty(...
                        strfind({'Names','IDs','Values'},k))); 


                %
                %   Assign node values
                %
                I = 1:NnodeKeys;
                for k = I;
                    Key = Keys{k};
                    if any(IsValidSubname(Key));
                        Key = strrep(strrep(Key,'Node',''),'s','');
                        G.Nodes.(Key) = Values(k);
                    end
                end
                
                
                %
                %   Assign edge values
                %
                I = NnodeKeys + (1:NedgeKeys);
                for k = I;
                    Key = Keys{k};
                    if any(IsValidSubname(Key))
                        Key = strrep(strrep(Key,'Edge',''),'s','');
                        G.Nodes.(Key) = Values(k);
                    end
                end
            end
            
        end

    end
    
    
    
end