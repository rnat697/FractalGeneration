function [nature] = JuliaSetPoints(complexValues, c, maximum)
% JuliaSetPoints function determinds whether or not each point in a grid of
% complex values is a member of the Julia Set associated with a specified
% complex value c.
% If the point in the grid is within the bounded region after the maximum
% iterations, it is deemed as a member of the Julia Set, & is assigned a
% value of 0.
% If it is not a member of the Julia set, it will be assigned a value that
% corresponds to the number of iterations it took for that point to exact
% the bounded region.
% -----------------------------------------------------------------------
% Inputs: complexValues = A 2d array that store the grid of complex values
%                         that we will determine the nature of.
%                     c = Specified complex value used to generate Julia set.
%               maximum = Cutoff value that determinds the maximum number of
%                         iterations to perform.
% Outputs:       nature = A 2D array describing the nature of each point on
%                         the grid.
% Author: Rachel Nataatmadja
% ------------------------------------------------------------------------

numRows = size(complexValues,1); % finds the number of rows in the grid of complex values
numCols = size(complexValues,2); % finds the number of columns in the grid of complex values

% preallocations of arrays
complArray = zeros(numRows,numCols);
nature = zeros(numRows,numCols);

%% ----- Storing Grid of Complex Values -----
% Stores the grid of complex values which can have any number of rows and
% columns.
complArray(:,:) = complexValues(:,:);

%% ----- Determinds Julia Set Points -----
% Determines whether each point in the complArray is a member of the Julia
% set.
for cols = 1:numCols
    for rows = 1:numRows
    nature(rows,cols) = IterateComplexQuadratic(max(complArray(rows,cols)),c,maximum);
    % Uses the IterateComplexQuadratic function to determine if its a Julia
    % set or not.
    end 
end

end