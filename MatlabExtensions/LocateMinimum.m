function [Minimum,Row,Col] = LocateMinimum(Matrix)
%=============================================================================%
% Purpose: Find and locate the minimum value within a given matrix.
%
% Important Notes: Does not gaurantee minimum is unique.
%=============================================================================%

NumberOfRows = size(Matrix,1)   ;          % Number of rows
Minimum      = min(min(Matrix)) ;          % Minimum.  

LinearLocation = find(Minimum == Matrix);  % Returns the linear location of 
                                           %   the nonzero elements of the 
                                           %   matrix.

Row = mod(LinearLocation,NumberOfRows);    % Finds the row number from the 
if (Row == 0)                              %   linear location and accounts for
    Row = NumberOfRows;                    %   a zero result as being on the 
end                                        %   final row.
      
Col = find(Minimum == Matrix(Row,:));      % Finds the column number from the 
if (Col == 0)                              %   linear location and accounts for
    Col = NumberOfRows;                    %   a zero result as being on the 
end                                        %   final column.

end
