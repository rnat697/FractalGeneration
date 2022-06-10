% Test or Mark all the eight specified functions for the 2020 matlab project
% To use this script requires a small amount of setup (see below).
%
%
% Author: Peter Bier
%
% Setup:
% You will need to add the TestScripts directory to the
% matlab path so that Matlab can find the test scripts and test data files
% To do this from within Matlab right click on the directory
% called TestScripts and choose add to path, "Selected folders and subfolders").
% Adding a directory to the Matlab path allows Matlab to locate anything
% in that directory.  This allows you to keep your test scripts separate
% from the directory your code is stored in.
% This script assumes that you will change into a working directory
% that contains the code you want to test.
% Once setup is complete you can test your code by typing TestAll from
% within your working directory.  You can also test individual functions
% using the appropriate marking script, e.g. calling TestColourJulia will
% test the ColourJulia function.
%
% Note that if a function name is mispelled you can still use
% scripts to test them, just specify the mode (test or mark) and function
% name as optional arguments (e.g. if the ColourJulia function is
% named incorrectly with a lower case "c" and "j", you could mark it by typing:
% TestColourJulia('test','colourjulia')

clear
clc

mode = 'test'; % can also use 'mark' mode to use marking data
% once it is distributed after the due date

% set up list of functions to mark
functionsList = {'CreateComplexGrid', 'IterateComplexQuadratic', ...
    'JuliaSetPoints','ColourJulia', 'GenerateJuliaSets', ...
    'ReadColourValues','LookupColourValues','CreateColourmap'};


divider='=======================================================';
totalMark = 0;
% Call the test function for each listed function, e.g. TestColourJulia
for i=1:length(functionsList)
    mark(i) = feval(['Test' functionsList{i}],mode,functionsList{i});
    totalMark = totalMark + mark(i);
    input('Hit enter to continue');
    disp(divider);
end

disp(['Your total functionality mark (excluding error checking) for the 8 functions is ' num2str(totalMark) '/24'])

% Next check the error handling for ReadColourValues and LookupColourValues

markErrorChecking = input('Do you wish to mark for error checking? Enter y for yes, n for no:','s');

if strncmp(lower(markErrorChecking),'y',1)
    
    % call ReadColourValues with a file name that doesn't exist
    disp('Testing error handling for ReadColourValues')
    disp('You should see an error message that reads:')
    disp('Error opening file doesNotExist.txt')
    try
        fprintf(1,'Calling ReadColourValues(''doesNotExist.txt'')\n')
        ReadColourValues('doesNotExist.txt')
    catch ex
    end
    
    ReadColourValuesErrorMark = input('Is the correct error message displayed?  Enter 1 for yes, 0 for no:');
    
    % call LookupColourValues with a colour name that doesn't exist
    disp('Testing error handling for LookupColourValues')
    disp('The values returned should be 0 0 0 and you should see an error message that reads:')
    disp('Colour not found')
    try
        fprintf(1,'Calling LookupColourValues(''green'',{''navy'';''purple''},[0 0 0.5; 0.5 0 0.5])\n')
        GreenValues  = LookupColourValues('green',{'navy';'purple'},[0 0 0.5; 0.5 0 0.5])
        
        if GreenValues == [0 0 0]
            disp('Correct values returned')
            LookupColourValuesErrorMark = input('Is the correct error message displayed?  Enter 1 for yes, 0 for no:');
        else
            disp('Incorrect values returned, you do not get this mark')
        end
    catch ex
        disp('Values not returned correctly, you do not get this mark')
        LookupColourValuesErrorMark = 0;
    end
    
    input('Hit enter to continue');
    
    errorMark = ReadColourValuesErrorMark + LookupColourValuesErrorMark;
    disp(['Your total error checking mark is ' num2str(errorMark) '/2'])
end



% Next call the timing scripts if all relevent tests passed and
% we wish to mark timing

markTiming = input('Do you wish to mark for timing? Enter y for yes, n for no:','s');

if strncmp(lower(markTiming),'y',1)
    timingMark = 0;
    
    % Time JuliaSetPoints if it passed all tests
    if mark(3) == 3
        timingMark = timingMark + TimeJuliaSetPoints;
    end
    input('Hit enter to continue');
    
    % Time ColourJulia if it passed all tests
    if mark(4) == 3
        timingMark = timingMark + TimeColourJulia;
    end
    input('Hit enter to continue');
    
    
    disp(['Your total timing mark is ' num2str(timingMark) '/2'])
    
    
end