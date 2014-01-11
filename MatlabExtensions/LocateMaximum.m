function [Maximum,Row,Col] = LocateMaximum(Matrix)
%=============================================================================%
% Purpose: Find and locate the maximum value within a given matrix.
%
% Important Notes: Does not gaurantee maximum is unique.
%=============================================================================%

MatrixSize  = size(Matrix)      ;          % Number of rows
Maximum     = max(max(Matrix))  ;          % Maximum.  

LinearLocation = find(Maximum == Matrix);  % Returns the linear location of 
                                           %   the nonzero elements of the 
                                           %   matrix.

[Row,Col] = ind2sub(MatrixSize,LinearLocation); %   Row and column location

end