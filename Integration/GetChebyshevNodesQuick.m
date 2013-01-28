function Nodes = GetChebyshevNodesQuick(Number,Start,End)
% Function Name:
%	GetChebyshevNodesQuick
% 
% Toolbox:       
%	Integration
% 
% Purpose:       
%	Produce a vector of Chebyshev nodes for use in numerical integration with 
%   no input checking/parsing.
%    
% Uses:
%
%	Nodes = GetChebyshevNodesQuick(Number,Start,End);
%       % Produces a vector %Number% long spanning [%Start%,%End%].
%
% Notes:
%	This function produces the same results as the GetChebyshevNodes function
%	but requires _all_ variables to be passed and does no input checking.
% See also
%	GetChebyshevNodes
    
    Argument	= 0.5 * pi * (2 * (1:Number) - 1) / Number					;
	Nodes		= 0.5 * ((Start + End) + (Start - End) * cos(Argument))		;
    
end
