function [mark] = TestGenerateJuliaSets(mode,specifiedFunctionName)
% Tests the GenerateJuliaSets function either with test or marking data
%
% It has two optional arguments, mode and specifiedFunctionName,
% mode specifies whether to use test or marking data
% (marking data is only provided after the deadline is passed)
% specifiedFunctionName can be used to specify a different filename for
% the function in the event that the author has mispelt their function name
%
% Example calls
%
% >> TestGenerateJuliaSets
% This will test a function called GenerateJuliaSets, using the test data
%
% >> TestGenerateJuliaSets('mark')
% This will use the marking data rather than test data
% Remember marking data isn't released until after the deadline
% It will be similar to (but not identical to) the test data
%
% >> TestGenerateJuliaSets('test','genJulia')
% This will test the function called genJulia
%
% >> TestGenerateJuliaSets('mark','generatejuliasets')
% This will test the function called generatejuliasets using the marking data
% rather than the test data.
%
% Remember GenerateJuliaSets takes three input(s) in the following order:
% 	1) a 1D array of complex values to generate Julia set fractals for
% 	2) n, a value specifying the grid size to use (the grid will be n×n)
% 	3) a 2D array of size r×3 containing a colour map (the number of rows, r,
%      in the colourmap will be used as the value for the cutoff when generating
%      the Julia sets). The colour values in each row will be between 0 and 1 inclusive,
%      representing the percentage of red, green and blue respectively,
%      for the colour in that row.
%
% It returns a single output, a cell array where each element contains an
% RGB image of a Julia set (as a 3D array of uint8 values of size n×n×3)
% for the corresponding complex value from the complex values array,
% will all Julia sets coloured using the provided colour map.
% author: Peter Bier

% default the mode and function name, if no optional args specified
if nargin == 0
    mode = 'test'; % default to using test data
    functionName = 'GenerateJuliaSets';
    
elseif nargin == 1
    % one input argument, mode will have been specified, no need to default
    % default functionName to that expected
    functionName = 'GenerateJuliaSets';
else
    % two inputs, mode and specified function name both passed in
    % no need to default mode but set functionName
    functionName = specifiedFunctionName;
end


% set up data with inputs and expected outputs
% can use test data or marking data, default is test data
% marking data only supplied after the due date
if ~strcmp(mode,'mark')
    load TestDataGenerateJuliaSets;
else
    try
        load MarkDataGenerateJuliaSets;
    catch ex
        disp('Error loading marking data');
        %disp(ex);
        disp('Marking data is not released until after the due date')
        disp('Once released you need to put in in the TestScripts directory')
        return
    end
end
input1 = GenerateJuliaSetsInput1;
input2 = GenerateJuliaSetsInput2;
input3 = GenerateJuliaSetsInput3;


expectedOutput1 = GenerateJuliaSetsExpectedOutput;

purpose = GenerateJuliaSetsTestPurpose;

totalPassed = 0;
numTests = length(input1);

% run all tests, comparing expected output against actual output
for i = 1:numTests
    m = sprintf('%s Test %i\n\tPurpose:\t%s \n\tResult:\t\t', functionName, i, purpose{i});
    
    try
        
        output1{i} = feval(functionName,input1{i},input2{i},input3{i});
        % check if result returned  matches the expected result
        
        
        if  isequal(expectedOutput1{i},output1{i})
            
            
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


