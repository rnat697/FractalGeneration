%% TESTINGGG
%% JuliaSetPoints Testing
grid100 = CreateComplexGrid(100);
points = JuliaSetPoints(grid100,-0.79+0.15i,10);
J1 = ColourJulia(points,jet(10));
J2 = ColourJulia(points,hot(10));
figure(1)
subplot(1,2,1)
imshow(J1)
subplot(1,2,2)
imshow(J2)

%% GenerateJuliaSets Testing
% tic
% cvalues = [-0.8+0.2i,-0.8+0.i,0-0.2i];
% ImageArray = GenerateJuliaSets(cvalues,500,jet(50));
% toc
% figure(1)
% subplot(1,3,1); 
% imshow(ImageArray{1})
% subplot(1,3,2); 
% imshow(ImageArray{2})
% subplot(1,3,3); 
% imshow(ImageArray{3})


