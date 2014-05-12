classdef (Abstract = true) GraphAbstract < handle
    
    properties
        %   This abstract class outlines the behavior only.
        %   The details of what data to store are left for concrete
        %   classes.
    end
    
    
    methods
        
        %   Test if node y is adjacent to node x
        TrueFalse = IsAdjacent(Graph,x,y)
        
        %   List of all neighboring nodes of node x
        Neighbors = ListNeighbors(Graph,x)
        
        %   Add a node x to the graph
        [] = AddNode(Graph,x)
        
        %   Add an edge between node x and node y
        [] = AddEdge(Graph,x,y)
        
        %   Delete node x from the graph
        [] = DeleteNode(Graph,x)
        
        %   Delete an edge specified by varargin
        [] = DeleteEdge(Graph,varargin)
        
        %   Retrieve the value stored by node x
        [] = GetNodeValue(Graph,x)
        
        %   Retrieve the value of an edge specified by varargin
        [] = GetEdgeValue(Graph,varargin)
        
        %   Set the value stored by node x
        [] = SetNodeValue(Graph,x)
        
        %   Set the value of an edge specified by varargin
        [] = SetEdgeValue(Graph,z)
    end
    
end