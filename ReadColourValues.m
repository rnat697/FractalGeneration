function [colours,colourValues] = ReadColourValues(fileName)
% ReadColourValues function reads in a list of colours names and their
% values from a specified text file. It returns the colour names in a cell 
% array and the colour values in a 2D array. An error message will be
% displayed if the text file can not be opened.
% ------------------------------------------------------------------------
% Input: fileName = Variable to store the string of the file name that
%                   stores a mapping of colournames to colour values.
% Output: colours = A cell array of colour names, where each element of the
%                   cell array is a colour name stored as a string.
%    colourValues = A 2D array of colour values of size rx3, where each row
%                   contains the three colour values read in from the file
%                   (for the colour in the corresponding row of the colour 
%                   names array). The values will be between 0 and 1.
% Author: Rachel Nataatmadja
% ------------------------------------------------------------------------

colours = {};
colourValues = [];
numberArray = [];
lineNum = 0;

fid = fopen(fileName,'r'); % opens file with read permission
%% ----- Opening File Error -----
if fid == -1
    error =  fprintf(2,['\nError opening file ',fileName, '\n']);
    disp(error) % displays error message when file can't be opened
    
else
    %% ----- Opened File Successfully -----
    line = fgetl(fid); % gets first line in the text file
    while (ischar(line))
        
        %% ----- Colour Name -----
        stringLine = strsplit(line); % splits the string in the line into cells
        colours = [colours;stringLine{1}]; % Stores the colour names in a cell array.
        
        %% ----- Colour Values -----
        % Finds the colour values in the string in the columns 2-4 in
        % stringLine.
        for j = 2:4
            % Finds the value in a specific column and converts the string
            % into an integer.
            num = str2double(stringLine{j}); 
            numberArray = [numberArray,num];
        end
        line = fgetl(fid); % gets a new line
        lineNum = lineNum +1; % to get the number of lines in the text file
    end
    
    %% ----- Colour Values Formatting -----
    % To produce a rx3 array.
    % finds the first 3 columns (rgb values) for the rx3 array
    startValue = numberArray(1,1:3); 
    colourValues = [startValue];
    for i = 1:lineNum-1
        colNum = (i*3)+1; % produces a starting number to use to search through the columns in numberArray
        
        % Finds and stores 3 consecutive integers (rgb values) in the same row, using
        % the starting number as the starting column.
        value = numberArray(1,colNum:(colNum+2));
        
        % stores each row of increments of three columns in a new row
        colourValues = [colourValues;value];
    end
    fclose(fid);
end
     

end