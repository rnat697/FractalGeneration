function [mark, averageTime] = TimeJuliaSetPoints(mode,specifiedFunctionName)
% Times the JuliaSetPoints function, assuming that JuliaSetPoints
% has already passed all tests (you are not eligible for
% any timing marks unless JuliaSetPoints works correctly - i.e. it must
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
% >> TimeJuliaSetPoints
% This will time a function called JuliaSetPoints, using the test data
%
% >> TimeJuliaSetPoints('mark')
% This will use the marking data rather than test data
% Remember marking data isn't released until after the deadline
% It will be similar to (but not identical to) the test data
%
% >> TimeJuliaSetPoints('test','juliasetpoints')
% This will tune the function called juliasetpoints
%
% >> TimeJuliaSetPoints('mark','juliasetpoints')
% This will use the marking data rather that the test data for
% the function called juliasetpoints


% default the mode and function name, if no optional args specified
if nargin == 0
    mode = 'test'; % default to using test data
    functionName = 'JuliaSetPoints';
elseif nargin == 1
    % one input argument, mode will have been specified, no need to default
    % the mode
    % default functionName to that expected
    functionName = 'JuliaSetPoints';
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
    load TestDataTimeJuliaSetPoints
else
    try 
        % mark mode was specified
        load MarkDataTimeJuliaSetPoints;
    catch ex
        disp('Error loading marking data');
        %disp(ex);
        disp('Marking data is not released until after the due date')
        disp('Once released you need to put in in the TestScripts directory')
        return
    end
end

input1 = TimeJuliaSetPointsInput1;
input2 = TimeJuliaSetPointsInput2;
input3 = TimeJuliaSetPointsInput3;


try
    fprintf('Begininning timing of three iterations for %s ...\n', functionName)
    for i=1:3
        tic % start the clock

        % make two calls to JuliaSetPoints
        Output = JuliaSetPoints(input1{1},input2{1},input3{1});
        Output = JuliaSetPoints(input1{2},input2{2},input3{2});

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
