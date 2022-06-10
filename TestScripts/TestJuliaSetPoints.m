function [mark] = TestJuliaSetPoints(mode,specifiedFunctionName)
% Tests the JuliaSetPoints function either with test or marking data
%
% It has two optional arguments, mode and specifiedFunctionName,
% mode specifies whether to use test or marking data
% (marking data is only provided after the deadline is passed)
% specifiedFunctionName can be used to specify a different filename for
% the function in the event that the author has mispelt their function name
%
% Example calls
%
% >> TestJuliaSetPoints
% This will test a function called JuliaSetPoints, using the test data
%
% >> TestJuliaSetPoints('mark')
% This will use the marking data rather than test data
% Remember marking data isn't released until after the deadline
% It will be similar to (but not identical to) the test data
%
% >> TestJuliaSetPoints('test','juliapoints')
% This will test the function called juliapoints
%
% >> TestJuliaSetPoints('mark','setpoints')
% This will test the function called setpoints using the marking data
% rather than the test data.
%
% Remember JuliaSetPoints takes three input(s) in the following order:
% 1.	a 2D array that stores the grid of complex values we will determine 
%       the nature of (i.e. whether or not they are points in the Julia set)
% 2.	a specified complex value, c, (used to generate the particular Julia set)
% 3.	a cutoff value that determines the maximum number of iterations to perform
% It returns a single output, a 2D array describing the nature of each point on the grid.  
% If a grid point is in the Julia set it will have a value of 0.  
% If a grid point is not in the Julia set it will have a value that
% corresponds to the number of complex quadratic iterations it took to exit 
% the bounded circular region (the maximum possible value of iterations will 
% be determined by the cutoff used when generating the Julia set)
% 
% author: Peter Bier

% default the mode and function name, if no optional args specified
if nargin == 0
    mode = 'test'; % default to using test data
    functionName = 'JuliaSetPoints';
    
elseif nargin == 1
    % one input argument, mode will have been specified, no need to default
    % default functionName to that expected
    functionName = 'JuliaSetPoints';
else
    % two inputs, mode and specified function name both passed in
    % no need to default mode but set functionName
    functionName = specifiedFunctionName;
end


% set up data with inputs and expected outputs
% can use test data or marking data, default is test data
% marking data only supplied after the due date
if ~strcmp(mode,'mark')
    load TestDataJuliaSetPoints;
else
    try
        load MarkDataJuliaSetPoints;
    catch ex
        disp('Error loading marking data');
        %disp(ex);
        disp('Marking data is not released until after the due date')
        disp('Once released you need to put in in the TestScripts directory')
        return
    end
end
input1 = JuliaSetPointsInput1;
input2 = JuliaSetPointsInput2;
input3 = JuliaSetPointsInput3;

expectedOutput1 = JuliaSetPointsExpectedOutput;

purpose = JuliaSetPointsTestPurpose;

totalPassed = 0;
numTests = length(input1);

% run all tests, comparing expected output against actual output
for i = 1:numTests
    m = sprintf('%s Test %i\n\tPurpose:\t%s \n\tResult:\t\t', functionName, i, purpose{i});
    
    try       
        output1{i} = feval(functionName,input1{i},input2{i},input3{i});
        % check if result returned matches the expected result      
        
        if  isequal(expectedOutput1{i},output1{i})
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


