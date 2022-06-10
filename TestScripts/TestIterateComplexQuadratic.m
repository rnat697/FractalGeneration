function [mark] = TestIterateComplexQuadratic(mode,specifiedFunctionName)
% Tests the IterateComplexQuadratic function either with test or marking data
%
% It has two optional arguments, mode and specifiedFunctionName,
% mode specifies whether to use test or marking data
% (marking data is only provided after the deadline is passed)
% specifiedFunctionName can be used to specify a different filename for
% the function in the event that the author has mispelt their function name
%
% Example calls
%
% >> TestIterateComplexQuadratic
% This will test a function called IterateComplexQuadratic, using the test data
%
% >> TestIterateComplexQuadratic('mark')
% This will use the marking data rather than test data
% Remember marking data isn't released until after the deadline
% It will be similar to (but not identical to) the test data
%
% >> TestIterateComplexQuadratic('test','IterateComplexQuad')
% This will test the function called IterateComplexQuad
%
% >> TestIterateComplexQuadratic('mark','ComplexQuadratic')
% This will test the function called ComplexQuadratic using the marking data
% rather than the test data.
%
% Remember IterateComplexQuadratic takes three inputs
% It takes three input(s) in the following order:
% 1.	z, the initial complex value that we begin the iteration process with
%         (this is the value to determine the nature of)
% 2.	c, a specified complex value (used to generate a particular Julia set)
% 3.	a cutoff value that determines the maximum number of iterations
%       to perform (this will be a positive integer value)
% It returns a single output, the number of iterations it took until
% |f(z)|?3  or 0 if the maximum number of iterations was reached and |f(z)|<3
% author: Peter Bier

% default the mode and function name, if no optional args specified
if nargin == 0
    mode = 'test'; % default to using test data
    functionName = 'IterateComplexQuadratic';
    
elseif nargin == 1
    % one input argument, mode will have been specified, no need to default
    % default functionName to that expected
    functionName = 'IterateComplexQuadratic';
else
    % two inputs, mode and specified function name both passed in
    % no need to default mode but set functionName
    functionName = specifiedFunctionName;
end


% set up data with inputs and expected outputs
% can use test data or marking data, default is test data
% marking data only supplied after the due date
if ~strcmp(mode,'mark')
    load TestDataIterateComplexQuadratic;
else
    try
        load MarkDataIterateComplexQuadratic;
    catch ex
        disp('Error loading marking data');
        %disp(ex);
        disp('Marking data is not released until after the due date')
        disp('Once released you need to put in in the TestScripts directory')
        return
    end
end
input1 = IterateComplexQuadraticInput1;
input2 = IterateComplexQuadraticInput2;
input3 = IterateComplexQuadraticInput3;

expectedOutput1 = IterateComplexQuadraticExpectedOutput;

purpose = IterateComplexQuadraticTestPurpose;

totalPassed = 0;
numTests = length(input1);

% run all tests, comparing expected output against actual output
for i = 1:numTests
    m = sprintf('%s Test %i\n\tPurpose:\t%s \n\tResult:\t\t', functionName, i, purpose{i});
    
    try
        
        output1{i} = feval(functionName,input1{i},input2{i},input3{i});
        % check if result returned closely matches the expected result
        
        
        if  isequal(expectedOutput1{i},output1{i})
            totalPassed = totalPassed + 1;
            disp([m 'Passed test']);
        else
            disp([m 'FAILED test']);
            disp(sprintf('Expected output was %i, output returned was %i',expectedOutput1{i}, output1{i}));
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


