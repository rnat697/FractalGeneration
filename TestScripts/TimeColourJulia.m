function [mark, averageTime] = TimeColourJulia(mode,specifiedFunctionName)
% Times the ColourJulia function, assuming that ColourJulia
% has already passed all tests (you are not eligible for
% any timing marks unless ColourJulia works correctly - i.e. it must
% have passed all the tests).
%
% It has two optional arguments, mode and specifiedFunctionName,
% mode specifies whether to use test or marking data
% (marking data is only provided after the deadline is passed)
% specifiedFunctionName can be used to specify a different filename for
% the function in the event that the author has mispelt their function name
%
% Example calls
%
% >> TimeColourJulia
% This will time a function called ColourJulia, using the test data
%
% >> TimeColourJulia('mark')
% This will use the marking data rather than test data
% Remember marking data isn't released until after the deadline
% It will be similar to (but not identical to) the test data
%
% >> TimeColourJulia('test','colorjulia')
% This will time the function called colorjulia
%
% >> TimeColourJulia('mark','colorjulia')
% This will use the marking data rather that the test data for
% the function called colorjulia


% default the mode and function name, if no optional args specified
if nargin == 0
    mode = 'test'; % default to using test data
    functionName = 'ColourJulia';
elseif nargin == 1
    % one input argument, mode will have been specified, no need to default
    % the mode
    % default functionName to that expected
    functionName = 'ColourJulia';
else
    % two inputs, mode and specified function name both passed in
    % no need to default mode but set functionName
    functionName = specifiedFunctionName;
end

% set up data with inputs and expected outputs
% can use test data or marking data
% marking data only supplied after the due date
% default is to use test data
if ~strcmpi(mode,'mark')
    load TestDataTimeColourJulia
else
    try 
        % mark mode was specified
        load MarkDataTimeColourJulia;
    catch ex
        disp('Error loading marking data');
        %disp(ex);
        disp('Marking data is not released until after the due date')
        disp('Once released you need to put in in the TestScripts directory')
        return
    end
end

input1 = TimeColourJuliaInput1;
input2 = TimeColourJuliaInput2;


try
    fprintf('Begininning timing of three iterations for %s ...\n', functionName)
    for i=1:3
        tic % start the clock
        Output = ColourJulia(input1,input2);
        time(i) = toc; % stop the clock
        fprintf('Time for iteration %i was %.4f\n',i,time(i));
    end
    
    averageTime = mean(time);
    fprintf('Summary for %s: ',functionName);
    if averageTime <1
        fprintf('Average time below 1 second\n Award 1 mark\n');
        mark = 1;
    else
        fprintf('Average time above 1 second\n  Award 0 marks\n');
        mark = 0;
    end
    
catch ex
    disp([functionName 'FAILED test']);
    ProcessMarkingException(ex, functionName)
    mark = 0;
    averageTime = 100;
end
