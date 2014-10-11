function Integral = QuadChebyshev(Function,varargin)
% Function Name:
%	QuadChebyshev
% 
% Toolbox:       
%	Integration
% 
% Purpose:       
%	Non-adaptively integrate a given function with Gauss-Chebyshev quadrature.
%    
% Uses:
% 
%	Nodes = QuadChebyshev(Function);
%       %   Integrates %Function% on the closed interval [-1,1] with 10 nodes.
% 
%	Nodes = QuadChebyshev(Function,Start,End);
%       %   Integrates %Function% on the closed interval [%Start%,%End%] with 10 
%       %   nodes.
%
%	Nodes = QuadChebyshev(Function,Start,End,N);
%       %   Integrates %Function% on the closed interval [%Start%,%End%] with N 
%       %   nodes.
%
% See also
%   
    
    
    Parser = inputParser()                                      ;
    Parser.addRequired('Function'    , @IsFunctionHandle      )	;
    Parser.addOptional('Start'   ,-1 , @IsRealScalar          )	;
    Parser.addOptional('End'     , 1 , @IsRealScalar          ) ;
    Parser.addOptional('Number'  , 10, @(x) IsIntegral(x,'+') )	;
    Parser.parse(Function,varargin{:})                         	;
    
    Start        = Parser.Results.Start                     ;
    End          = Parser.Results.End                       ;
    Number       = Parser.Results.Number                    ;
    Shift1       = 0.5 * (End - Start)                      ;
    Shift2       = 0.5 * (End + Start)                      ;
    eta          = @(x) Shift1 * x + Shift2                 ;
    Integrand    = @(x) Function(eta(x)) .* sqrt(1-x.^2)    ;
    Nodes        = GetChebyshevNodesQuick(Number,-1,1)      ;
    Weight       = pi / Number                              ;
    Integral     = Shift1 * sum(Integrand(Nodes)) * Weight	;
    
end