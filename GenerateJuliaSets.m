function [juliaSetImage] = GenerateJuliaSets(complexValues,gridSize,colourMap)
% GenerateJuliaSets function takes a sequence of complex values and
% generates the corresponding sequence of Julia set images.
% ------------------------------------------------------------------------
% Inputs: complexValues = A 1D array of complex values to generate Julia
%                         set fractals for.
%              gridSize = A value specifying the grid size to use (a nxn
%                         grid).
%             colourMap = 2D array of size rx3 containing a colour map
% Outputs: juliaSetImage = a cell array where each element contains an RGB
%                          image of a Julia set for the corresponding 
%                          complex value from the complexValues array.
% Author: Rachel Nataatmadja
% ------------------------------------------------------------------------

%% ----- Creating Grid of Complex Values -----
grid = CreateComplexGrid(gridSize); % creates a grid of complex values in a nxn array
cutoff = size(colourMap,1); % determines the maximum value of iterations for the points to go through from the number of rows
juliaSetImage = [];

%% ----- Creating Julia Set Image -----
% Goes through the 1D array of complex values.
for i = 1:length(complexValues)
    % determines the nature of the points (of complex values)
    points = JuliaSetPoints(grid,complexValues(i),cutoff);
    
    % colours the points using ColourJulia function
    colourImage = {ColourJulia(points,colourMap)};
    juliaSetImage = [juliaSetImage,colourImage]; % stores the coloured image into a cell array
end

end