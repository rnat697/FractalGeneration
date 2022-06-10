
fileName = 'RoyalColours.txt'
colours = {};
colourValues = [];
numberArray = [];
lineNum = 0;
fid = fopen(fileName,'r');
%% ----- Opening File Error -----
if fid == -1
    error =  fprintf(2,['\nError opening file ',fileName, '\n']);
    disp(error)
else
    %% ----- Opened File Successfully -----
    line = fgetl(fid); % gets first line in the text file
    while (ischar(line))
        %% ----- Colour Name -----
        stringLine = strsplit(line); % splits the string in the line into cells
        % stores the colour names in a cell array
        colours = [colours;stringLine{1}];
        
        %% ----- Colour Values -----
        % finds the colour values in the string in the columns 2-4 in
        % stringLine
        for j = 2:4
            % finds the value in a specific column and converts the string
            % into an integer
            num = str2double(stringLine{j}); 
            numberArray = [numberArray;num];
        end
        line = fgetl(fid); % gets a new line
        lineNum = lineNum +1; % to get the number of lines in the text file
    end
    disp(numberArray)
    %% ----- Colour Values Formatting -----
    % to produce a rx3 array
    % finds the first 3 columns for the rx3 array
%     startValue = numberArray(1,1:3); 
%     colourValues = [startValue];
%     for i = 1:lineNum-1
%         colNum = (i*3)+1; % produces a starting number to use to search through the columns in numberArray
%         % Finds and stores 3 consecutive integers in the same row, using
%         % the starting number as the starting column.
%         value = numberArray(1,colNum:(colNum+2));
%         % stores each row of increments of three columns in a new row
%         colourValues = [colourValues;value];
%     end
end