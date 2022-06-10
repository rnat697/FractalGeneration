function [lookup] = LookupColourValues(colour,namesArray,colourValues)
% LookupColourValues looks up the colour values for a names colour, from a
% list of provided colours and their values. It should ignore the case of
% the name. If the colour is not found an error message is displayed saying
% 'Colour not found' and the default colour values of 000 are returned.
% ------------------------------------------------------------------------
% Inputs:  colour = A string containing the name of a colour to look up
%      namesArray = A cell array of colour names, where each element of the
%                   cell array is a colour anme stored as a string.
%    colourValues = A 2D array of colour values of size rx3, where each row
%                   contains the three colour values read in from the file.
%                   The values in a row will be between 0 and 1 inclusive,
%                   representing the percentage of red,green and blue
%                   respectively.
% Outputs: lookup = A 1x3 element array of colour values for the colour to
%                   look up. The values in a row will be between 0 and 1
%                   inclusive, representing the percentage of red,green and
%                   blue respectively.
% Author: Rachel Nataatmadja
% ------------------------------------------------------------------------

%% ----- Going Through Elements in Cell -----
for i = 1:length(namesArray) % goes through each element in the cell array
    search = strcmpi(colour,namesArray(i)); % compares provided string(variable: colour) with the string in the element
    
    %% ----- Checks if The String is The Same -----
    if search == 1 % if the string in the element is the same as the string in the variable colour
        lookup = colourValues(i,1:3); % looks up the colour values for the given colour
        break
    
    %% ----- No Colours Found -----
    elseif search == 0 && i == length(namesArray) 
    % Checks if the element is not the same as the string and has reached
    % the end of the array.
        error = fprintf(2,'\nColour not found\n');
        disp(error); % outputs an error message
        lookup = [0,0,0]; % default color values
        break
    end
end
