function [Minimum,Row,Col] = LocateMinimum(Matrix)
%=============================================================================%
% Purpose: Find and locate the minimum value within a given matrix.
%
% Important Notes: Does not gaurantee minimum is unique.
%=============================================================================%

MatrixSize  = size(Matrix)      ;          % Number of rows
Minimum     = max(max(Matrix))  ;          % Minimum.  

LinearLocation = find(Minimum == Matrix);  % Returns the linear location of 
                                           %   the nonzero elements of the 
                                           %   matrix.

[Row,Col] = ind2sub(MatrixSize,LinearLocation); %   Row and column location

end