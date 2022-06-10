function [mark] = TestLookupColourValues(mode,specifiedFunctionName)
% Tests the LookupColourValues function either with test or marking data
%
% It has two optional arguments, mode and specifiedFunctionName,
% mode specifies whether to use test or marking data
% (marking data is only provided after the deadline is passed)
% specifiedFunctionName can be used to specify a different filename for
% the function in the event that the author has mispelt their function name
%
% Example calls
%
% >> TestLookupColourValues
% This will test a function called LookupColourValues, using the test data
%
% >> TestLookupColourValues('mark')
% This will use the marking data rather than test data
% Remember marking data isn't released until after the deadline
% It will be similar to (but not identical to) the test data
%
% >> TestLookupColourValues('test','lookupcolourvalues')
% This will test the function called lookupcolourvalues
%
% >> TestLookupColourValues('mark','lookup')
% This will test the function called lookup using the marking data
% rather than the test data.
%
% Remember LookupColourValues takes three inputs in the following order:
% 1)	a string containing the name of a colour to look up
% 2)	a cell array of colour names, where each element of the cell array 
% is a colour name stored as a string.  
% 3) a 2D array of colour values of size r×3, where each row contains the 
% three colour values read in from the file (for the colour in the 
% corresponding row of the colour names array). The values in a row will be 
% between 0 and 1 inclusive, representing the percentage of red, green and 
% blue respectively.
% It returns a single output, a 1×3 element array of colour values for the 
% colour to look up.  
% author: Peter Bier

% default the mode and function name, if no optional args specified
if nargin == 0
    mode = 'test'; % default to using test data
    functionName = 'LookupColourValues';
    
elseif nargin == 1
    % one input argument, mode will have been specified, no need to default
    % default functionName to that expected
    functionName = 'LookupColourValues';
else
    % two inputs, mode and specified function name both passed in
    % no need to default mode but set functionName
    functionName = specifiedFunctionName;
end


% set up data with inputs and expected outputs
% can use test data or marking data, default is test data
% marking data only supplied after the due date
if ~strcmp(mode,'mark')
    load TestDataLookupColourValues;
else
    try
        load MarkDataLookupColourValues;
    catch ex
        disp('Error loading marking data');
        %disp(ex);
        disp('Marking data is not released until after the due date')
        disp('Once released you need to put in in the TestScripts directory')
        return
    end    
end

input1 = LookupColourValuesInput1;
input2 = LookupColourValuesInput2;
input3 = LookupColourValuesInput3;

expectedOutput1 = LookupColourValuesExpectedOutput;

purpose = LookupColourValuesTestPurpose;

totalPassed = 0;
numTests = length(input1);

% run all tests, comparing expected output against actual output
for i = 1:numTests
    m = sprintf('%s Test %i\n\tPurpose:\t%s \n\tResult:\t\t', functionName, i, purpose{i});
    
    try
        
        output1{i} = feval(functionName,input1{i},input2{i},input3{i});
        % check if result returned closely matches the expected result
      
        if isequal(expectedOutput1{i},output1{i})
            totalPassed = totalPassed + 1;
            disp([m 'Passed test']);
        else
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


