function [juliaImage] = ColourJulia(nature,colourMap)
% ColourJulia function colours the points in a Julia set black and the
% points outside of the set an appropriate shade of colour selected from a
% provided colour map.
% ------------------------------------------------------------------------
% Inputs:      nature = 2D array describing the nature of each point on a
%                       grid.
%           colourMap = 2D array of size rx3 containing a colour map,values
%                       between 0 and 1 representing the percentage of red, 
%                       green and blue for the colour in that row.
% Outputs: juliaImage = An RGB image of the Julia set. Points in Julia set
%                       will be coloured black, points notin the set will 
%                       be coloured using the provided colour map.
% Author: Rachel Nataatmadja
% ------------------------------------------------------------------------

numRows = size(nature,1); % finds the number of rows in the nature array
numCols = size(nature,2); % finds the number of columns in the grid of complex values
juliaImage = zeros(numRows,numCols,3,'uint8'); % initialises the image array

%% ----- Colouring Julia Set -----
for cols = 1:numCols
    for rows = 1:numRows
        natureNum = nature(rows,cols); % finds a particular nature in the array
        
        %% ----- Julia Set RGB Colour -----
        if natureNum == 0 % if the point is a part of the Julia set
            % leaves the rgb value as 000, black (due to zeros function creating an numRows x numCols array of zeros)
            continue
        
        else
              %% ----- Non-Julia Set RGB Colours -----
            % Sets the rgb values of the non-Julia set from the row (in the
            % colourMap) corresponding to the value of the nature.
            juliaImage(rows,cols,:) = 255*colourMap(natureNum,:);
        end
    end 
end 

end