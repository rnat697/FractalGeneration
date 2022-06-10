function [mark] = TestCreateComplexGrid(mode,specifiedFunctionName)
% Tests the CreateComplexGrid function either with test or marking data
%
% It has two optional arguments, mode and specifiedFunctionName,
% mode specifies whether to use test or marking data
% (marking data is only provided after the deadline is passed)
% specifiedFunctionName can be used to specify a different filename for
% the function in the event that the author has mispelt their function name
%
% Example calls
%
% >> TestCreateComplexGrid
% This will test a function called CreateComplexGrid, using the test data
%
% >> TestCreateComplexGrid('mark')
% This will use the marking data rather than test data
% Remember marking data isn't released until after the deadline
% It will be similar to (but not identical to) the test data
%
% >> TestCreateComplexGrid('test','createcomplexgrid')
% This will test the function called createcomplexgrid
%
% >> TestCreateComplexGrid('mark','ComplexGrid')
% This will test the function called ComplexGrid using the marking data
% rather than the test data.
%
% Remember CreateComplexGrid takes one input
%  n, a positive integer specifying the number of rows and columns for the output array
%
% It returns a single output,
% an n×n 2D array of equally spaced complex values representing a grid over
% the complex plane, where the 4 corners of the grid are the points
% -2+2i (top left), 2+2i (top right), -2-2i (bottom left) and 2-2i (bottom right)
%
% author: Peter Bier

% default the mode and function name, if no optional args specified
if nargin == 0
    mode = 'test'; % default to using test data
    functionName = 'CreateComplexGrid';
    
elseif nargin == 1
    % one input argument, mode will have been specified, no need to default
    % default functionName to that expected
    functionName = 'CreateComplexGrid';
else
    % two inputs, mode and specified function name both passed in
    % no need to default mode but set functionName
    functionName = specifiedFunctionName;
end


% set up data with inputs and expected outputs
% can use test data or marking data, default is test data
% marking data only supplied after the due date
if ~strcmp(mode,'mark')
    load TestDataCreateComplexGrid;
else
    try
        load MarkDataCreateComplexGrid;
    catch ex
        disp('Error loading marking data');
        %disp(ex);
        disp('Marking data is not released until after the due date')
        disp('Once released you need to put in in the TestScripts directory')
        return
    end
end
input1 = CreateComplexGridInput;

expectedOutput1 = CreateComplexGridExpectedOutput;

purpose = CreateComplexGridTestPurpose;

totalPassed = 0;
numTests = length(input1);

% run all tests, comparing expected output against actual output
for i = 1:numTests
    m = sprintf('%s Test %i\n\tPurpose:\t%s \n\tResult:\t\t', functionName, i, purpose{i});
    
    try
        
        output1{i} = feval(functionName,input1{i});
        % check if result returned closely matches the expected result
        tolerance = 1e-8;
        
        % check size of outputs matches and then check they are within
        % tolerance of each other
        if size(output1{i}) == size(expectedOutput1{i})
            if  abs(expectedOutput1{i}-output1{i}) < tolerance
                totalPassed = totalPassed + 1;
                disp([m 'Passed test']);
            else
                disp([m 'FAILED test']);
            end
        else
            disp([m 'FAILED test, expected output size differs from output received']);
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


