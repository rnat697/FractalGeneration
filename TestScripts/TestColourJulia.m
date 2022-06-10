function [mark] = TestColourJulia(mode,specifiedFunctionName)
% Tests the ColourJulia function either with test or marking data
%
% It has two optional arguments, mode and specifiedFunctionName,
% mode specifies whether to use test or marking data
% (marking data is only provided after the deadline is passed)
% specifiedFunctionName can be used to specify a different filename for
% the function in the event that the author has mispelt their function name
%
% Example calls
%
% >> TestColourJulia
% This will test a function called ColourJulia, using the test data
%
% >> TestColourJulia('mark')
% This will use the marking data rather than test data
% Remember marking data isn't released until after the deadline
% It will be similar to (but not identical to) the test data
%
% >> TestColourJulia('test','colourjulia')
% This will test the function called colourjulia
%
% >> TestColourJulia('mark','Colorjulia')
% This will test the function called Colorjulia using the marking data
% rather than the test data.
%
% Remember ColourJulia takes two input(s) in the following orde
% 1) a 2D array describing the nature of each point on a grid.
%    If a grid point is in the Julia set, it will have a value of 0.
%    If a grid point is not in the Julia set, it will have a positive integer
%    value less than or equal to the cutoff used when generating the Julia set
%    (this value corresponds to the number of complex quadratic iterations it
%    took for that point to exit the bounded circular region)
%
% 2) a 2D array of size r×3 containing a colour map (the number of rows, r,
%    in the colourmap must match the value of the cutoff used to generate the
%    Julia set). The colour values in a row will be between 0 and 1 inclusive,
%    representing the percentage of red, green and blue respectively,
%    for the colour in that row.
%
% It returns a single output, an RGB image of the Julia set. Points in the
% Julia set will be coloured as black.  Points not in the set will be
% coloured using the provided colour map
%
% author: Peter Bier

% default the mode and function name, if no optional args specified
if nargin == 0
    mode = 'test'; % default to using test data
    functionName = 'ColourJulia';
    
elseif nargin == 1
    % one input argument, mode will have been specified, no need to default
    % default functionName to that expected
    functionName = 'ColourJulia';
else
    % two inputs, mode and specified function name both passed in
    % no need to default mode but set functionName
    functionName = specifiedFunctionName;
end


% set up data with inputs and expected outputs
% can use test data or marking data, default is test data
% marking data only supplied after the due date
if ~strcmp(mode,'mark')
    load TestDataColourJulia;
else
    try
        load MarkDataColourJulia;
    catch ex
        disp('Error loading marking data');
        %disp(ex);
        disp('Marking data is not released until after the due date')
        disp('Once released you need to put in in the TestScripts directory')
        return
    end
end
input1 = ColourJuliaInput1;
input2 = ColourJuliaInput2;

expectedOutput1 = ColourJuliaExpectedOutput;

purpose = ColourJuliaTestPurpose;

totalPassed = 0;
numTests = length(input1);

% run all tests, comparing expected output against actual output
for i = 1:numTests
    m = sprintf('%s Test %i\n\tPurpose:\t%s \n\tResult:\t\t', functionName, i, purpose{i});
    
    try
        
        output1{i} = feval(functionName,input1{i},input2{i});
        % check if result returned  matches the expected result
        
        
        if  isequal(expectedOutput1{i},output1{i})
            
            % values are the same, but need to check type too
            if isa(output1{i},'uint8')
                totalPassed = totalPassed + 1;
                disp([m 'Passed test']);
            else
                
                disp ([m 'FAILED test']);
                fprintf(1,'\tReason:\t\tValues were correct but your array was not of type uint8\n')
            end
            
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


