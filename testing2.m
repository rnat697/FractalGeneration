tic
complexValues = CreateComplexGrid(100);
c = -0.79+15i;
maximum = 10;

numRows = size(complexValues,1); % finds the amount of rows in the grid of complex values
numCols = size(complexValues,2); % finds the amount of columns in the grid of complex values
% preallocations of arrays
complArray = zeros(numRows,numCols);
nature = zeros(numRows,numCols);

%% ----- Storing Grid of Complex Values -----
% stores the grid of complex values which can have any number of rows and
% columns
complArray(:,:) = complexValues(:,:);

%% ----- Determinds Julia Set Points -----
% Determines whether each point in the complArray is a member of the Julia
% set
[cols,rows] = meshgrid(1:numCols,1:numRows);
nature(rows,cols) = IterateComplexQuadratic(complArray(cols,rows),c,maximum);
% for cols = 1:numCols
%      for rows = 1:numRows
%      nature(rows,cols) = IterateComplexQuadratic(max(complArray(rows,cols)),c,maximum);
%      % uses the IterateComplexQuadratic function to determine if its a Julia
%      % Set or not.
%      end 
%  end
toc
J1 = ColourJulia(nature,jet(10));
J2 = ColourJulia(nature,hot(10));
figure(1)
subplot(1,2,1)
imshow(J1)
subplot(1,2,2)
imshow(J2)

