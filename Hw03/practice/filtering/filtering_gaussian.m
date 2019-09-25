
% ----------------------------------------------
clear
% set all Figure size to full screen
set(groot, 'defaultFigureUnits','normalized')
set(groot, 'defaultFigurePosition',[0 0 1 1])
% ----------------------------------------------


% rgb image
imcl = imread('parrot.jpg');

% create a filter: Gaussian
G = fspecial('gaussian', [5 5], 1)

% apply filters
Jgaussian = imfilter(imcl, G, 0);

% display
figure
subplot(1, 2, 1)
imshow(imcl)
subplot(1, 2, 2)
imshow(Jgaussian)
