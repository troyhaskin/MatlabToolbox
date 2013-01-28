function Nodes = GetChebyshevNodes(Number,Start,End)
% Function Name:
%	GetChebyshevNodes
% 
% Toolbox:       
%	Integration
% 
% Purpose:       
%	Produce a vector of Chebyshev nodes for use in numerical integration.
%    
% Uses:
% 
%	Nodes = GetChebyshevNodes(Number);
%       % Produces a vector %Number% long spanning [-1,1].
% 
%   Nodes = GetChebyshevNodes(Number,Start,End);
%       % Produces a vector %Number% long spanning [%Start%,%End%].
%
% See also
%   GetChebyshevNodesQuick
	
	if     ((nargin == 1) && (Number >  0))
		Start	= -1.0															;
		End		=  1.0															;
	
    elseif ((nargin == 1) && (Number <= 0))
        error('MyToolbox:GetChebyshevNodes:InvalidNodeNumber'                   , ...
              'Number of nodes must be a positive, non-zero integer.')          ;
		
	elseif ((nargin == 2) || (nargin <  1))
		error('MyToolbox:GetChebyshevNodes:TooFewInputs'                        , ...
              'Received starting point %f without end point',Start)             ;
		
	elseif (nargin > 3)
		error('MyToolbox:GetChebyshevNodes:TooManyInputs'                       ,...
              'Maximum number of 3 inputs to GetChebyshevNodes')                ;
        
	end
	
	
	Argument	= 0.5 * pi * (2 * (1:Number) - 1) / Number                      ;
	Nodes		= 0.5 * ((Start + End) + (Start - End) * cos(Argument))			;
    
end