function [mark] = TestCreateColourmap(mode,specifiedFunctionName)
% Tests the CreateColourmap function either with test or marking data
%
% It has two optional arguments, mode and specifiedFunctionName,
% mode specifies whether to use test or marking data
% (marking data is only provided after the deadline is passed)
% specifiedFunctionName can be used to specify a different filename for
% the function in the event that the author has mispelt their function name
%
% Example calls
%
% >> CreateColourmap
% This will test a function called CreateColourmap, using the test data
%
% >> CreateColourmap('mark')
% This will use the marking data rather than test data
% Remember marking data isn't released until after the deadline
% It will be similar to (but not identical to) the test data
%
% >> CreateColourmap('test','CreateColourmap')
% This will test the function called CreateColourmap
%
% >> CreateColourmap('mark','colourmap')
% This will test the function called colourmap using the marking data
% rather than the test data.
%
% Remember CreateColourmap It takes three inputs in the following order:
%	1) a 1×3 element array of colour values for the starting colour for the map. 
%   The values in this row vector will be between 0 and 1 inclusive, 
%   representing the percentage or red, green and blue respectively.
%	2) a 1×3 element array of colour values for the ending colour for the map. 
%   The values in this row vector will be between 0 and 1 inclusive, representing 
%   the percentage or red, green and blue respectively.
% 3) n, the number of rows to generate for the colour map array
%
% It returns a single output, a colour map in the form of an n×3 element array,
% where each row represents a colour
%
% author: Peter Bier

% default the mode and function name, if no optional args specified
if nargin == 0
    mode = 'test'; % default to using test data
    functionName = 'CreateColourmap';
    
elseif nargin == 1
    % one input argument, mode will have been specified, no need to default
    % default functionName to that expected
    functionName = 'CreateColourmap';
else
    % two inputs, mode and specified function name both passed in
    % no need to default mode but set functionName
    functionName = specifiedFunctionName;
end


% set up data with inputs and expected outputs
% can use test data or marking data, default is test data
% marking data only supplied after the due date
if ~strcmp(mode,'mark')
    load TestDataCreateColourmap;
else
    try
        load MarkDataCreateColourmap;
    catch ex
        disp('Error loading marking data');
        %disp(ex);
        disp('Marking data is not released until after the due date')
        disp('Once released you need to put in in the TestScripts directory')
        return
    end
end
input1 = CreateColourmapInput1;
input2 = CreateColourmapInput2;
input3 = CreateColourmapInput3;

expectedOutput1 = CreateColourmapExpectedOutput;

purpose = CreateColourmapTestPurpose;

totalPassed = 0;
numTests = length(input1);

% run all tests, comparing expected output against actual output
for i = 1:numTests
    m = sprintf('%s Test %i\n\tPurpose:\t%s \n\tResult:\t\t', functionName, i, purpose{i});
    
    try
        
        output1{i} = feval(functionName,input1{i},input2{i},input3{i});
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


