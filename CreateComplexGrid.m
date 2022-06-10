function [grid] = CreateComplexGrid(n)
% CreateComplexGrid function produces a 2D array of the size n x n which
% stores complex values drawn from a square grid od equally spaced points.
% ------------------------------------------------------------------------
% Bounded by the lines: -2+2i, 2+2i, -2-2i, 2-2i
% Input:     n = Positive integer specifying the number of rows and columns 
%                for the output array.
% Output: grid = A n by n 2D array of equally spaced complex values representing a
%                grid over the complex planes. Includes 4 corners of the grid that
%                have the points -2+2i(top left), 2+2i (top right), 
%                -2-2i (bottom left), 2-2i (bottom right).
% Author: Rachel Nataatmadja
% ------------------------------------------------------------------------

%% ----- Creating Complex Values from given Corners -----
top = linspace(-2+2i,2+2i,n); % creates evenly spaced values between the top corners of the Complex grid and has n number of points
bottom = linspace(-2-2i,2-2i,n); % evenly spaced values between the bottom corners, generating n number of points
grid = zeros(n); % preallocates the array to store the complex values

%% ----- Generating Complex nxn Grid -----
% Goes through and picks out n number of complex values for n rows and n
% columns.
for j = 1:n
    % This picks out n number of values starting from column number j in 
    % the bottom array to the column number j in the top array.
    array = linspace(bottom(j),top(j),n); % produces an evenly spaced 1D vector of values with n columns
    grid(1:n,j) = [array']; % transposes the 1D vector into the grid
 end

end