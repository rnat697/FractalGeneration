function [colourmap] = CreateColourmap(startcol,endcolour,rows)
% CreateColourmap functioncreates a custom colour map, with n shade of 
% colour that range from a specified starting colour through to a specified
% ending colour.
% ------------------------------------------------------------------------
% Inputs:    startcol = The starting 1x3 element array of colour values
%                       (between 0 and 1).
%           endcolour = The ending 1x3 element array of colour values
%                       (between 0 and 1).
%                rows = The number of rows to generate for the colour map
%                       array.
% Outputs: colour map = A colour map of nx3 element array, each row
%                       represents a colour, values between 0 and 1, 
%                       representing percentage of red, green and blue 
%                       respectively.
% Author: Rachel Nataatmadja
% ------------------------------------------------------------------------

%% ----- Assigning Start and End Colours -----
% Finds the corresponding rgb starting and ending value in the startcol 
% and endcolour array.
rStartcol = startcol(1);
gStartcol = startcol(2);
bStartcol = startcol(3);
rEndcolour = endcolour(1);
gEndcolour = endcolour(2);
bEndcolour = endcolour(3);

%% ----- Creating Colour Map Array -----
% Creates an array of values for each colour from a specified starting
% value to a specified ending value, equally spaced and has a specified
% number of points (rows).
red = linspace(rStartcol,rEndcolour,rows); 
green = linspace(gStartcol,gEndcolour,rows);
blue = linspace(bStartcol,bEndcolour,rows);

% Stores the rgb colour values in a colour map array that has n rows by 3
% columns.
colourmap = [red',green',blue']; % transposes each element in the variable
end
