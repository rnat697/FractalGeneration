function [mark] = TestReadColourValues(mode,specifiedFunctionName)
% Tests the ReadColourValues function either with test or marking data
%
% It has two optional arguments, mode and specifiedFunctionName,
% mode specifies whether to use test or marking data
% (marking data is only provided after the deadline is passed)
% specifiedFunctionName can be used to specify a different filename for
% the function in the event that the author has mispelt their function name
%
% Example calls
%
% >> TestReadColourValues
% This will test a function called ReadColourValues, using the test data
%
% >> TestReadColourValues('mark')
% This will use the marking data rather than test data
% Remember marking data isn't released until after the deadline
% It will be similar to (but not identical to) the test data
%
% >> TestReadColourValues('test','readvals')
% This will test the function called readvals
%
% >> TestReadColourValues('mark','ReadValues')
% This will test the function called ReadValues using the marking data
% rather than the test data.
%
% Remember ReadColourValues takes It takes a single input, a string
% containing the filename of a text file that stores a mapping of colour
% names to colour values.
%
% It returns two outputs in the following order:
% 1) a cell array of colour names, where each element of the cell array
% is a colour name stored as a string.  This array should have r rows and
% 1 column where the number of rows corresponds to the number of colour
% names read from the file.
%
% 2) a 2D array of colour values of size r×3, where each row contains the
% three colour values read in from the file
% author: Peter Bier

% default the mode and function name, if no optional args specified
if nargin == 0
    mode = 'test'; % default to using test data
    functionName = 'ReadColourValues';
    
elseif nargin == 1
    % one input argument, mode will have been specified, no need to default
    % default functionName to that expected
    functionName = 'ReadColourValues';
else
    % two inputs, mode and specified function name both passed in
    % no need to default mode but set functionName
    functionName = specifiedFunctionName;
end


% set up data with inputs and expected outputs
% can use test data or marking data, default is test data
% marking data only supplied after the due date
if ~strcmp(mode,'mark')
    load TestDataReadColourValues;
else
    try
        load MarkDataReadColourValues;
    catch ex
        disp('Error loading marking data');
        %disp(ex);
        disp('Marking data is not released until after the due date')
        disp('Once released you need to put in in the TestScripts directory')
        return
    end
end
input1 = ReadColourValuesInput1;

expectedOutput1 = ReadColourValuesExpectedOutput1;
expectedOutput2 = ReadColourValuesExpectedOutput2;

purpose = ReadColourValuesTestPurpose;

totalPassed = 0;
numTests = length(input1);

% run all tests, comparing expected output against actual output
for i = 1:numTests
    m = sprintf('%s Test %i\n\tPurpose:\t%s \n\tResult:\t\t', functionName, i, purpose{i});
    
    try      
        [output1{i},output2{i}] = feval(functionName,input1{i});
        % check if result returned  matches the expected result
     
        if  isequal(expectedOutput1{i},output1{i}) && isequal(expectedOutput2{i},output2{i})
            
            totalPassed = totalPassed + 1;
            disp([m 'Passed test']);
            
        else % values different
            disp([m 'FAILED test']);
        end
        
    catch ex
        disp([m 'FAILED test']);
        ProcessMarkingException(ex, functionName)
    end
    
end

% display marks summary
allocatedMarks = 3;
mark = ProcessMarksSummary(functionName,totalPassed,numTests,allocatedMarks);

end


