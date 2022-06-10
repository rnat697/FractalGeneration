function [iteration] = IterateComplexQuadratic(z,c,cutoff)
% IterateComplexQuadratic function that repeatedly applies the complex
% quadratic f(z) = z^2 +c for a specified value of z and c.
% This continues until the value of f(z) is no longer within the bounded
% region |f(z)| >= 3 or the maximum number of iterations is reached
% (specified by cutoff).
% ------------------------------------------------------------------------
% Inputs:          z = Initial complex value. 
%                  c = Specified complex value (used to generate a particular
%                      Julia set).
%             cutoff = Cutoff value that determines the maxmium number of
%                       iterations to perform (positive integer).
% Output: iterations = Number of iterations it took until |f(z)| >= 3 or 0
%                      if the maximum number of iterations was reached 
%                      and |f(z)| < 3.
% Author: Rachel Nataatmadja
% ------------------------------------------------------------------------

f = z^2 + c;
iteration = 1; % first iteration

for j = 1:cutoff % 2nd iteration onwards until the cutoff or when f >=3
    %% ----- Is |f| Greater than 3? -----
    % checks if the magnitude of f is greater than or equal to 3
    if abs(f) >= 3
        break % terminates for loop
    
    %% ----- Is |f| Less Than 3 and Maximum Iterations Reached? -----    
    % checks if magnitude of f is less than 3 and the cutoff has been
    % reached.
    elseif abs(f) < 3 && j == cutoff
        iteration = 0;
        break % terminates for loop
    end
    
    f = f^2 + c; % repeatedly applies the complex quadratic
    iteration = iteration + 1; % counts the iterations that has passed
end

end