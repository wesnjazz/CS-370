
% ----------------------------------------------
clear
% set all Figure size to full screen
set(groot, 'defaultFigureUnits','normalized')
set(groot, 'defaultFigurePosition',[0 0 1 1])
% ----------------------------------------------


% rgb image
imcl = imread('parrot.jpg');

% create a filter blur (3x3)
blur = zeros(3,3);
blur(:,:) = 1/9

% create a filter enhance the pixel value (3x3)
enhance = zeros(3,3);
enhance(2,2) = 2

% sharpening filter
sharpen = enhance - blur

% apply filters
Jenhance = imfilter(imcl, enhance);
Jblur = imfilter(imcl, blur);
Jsharp = imfilter(imcl, sharpen);

% display
figure
subplot(1, 4, 1)
imshow(imcl)
subplot(1, 4, 2)
imshow(Jsharp)
subplot(1, 4, 3)
imshow(Jenhance)
subplot(1, 4, 4)
imshow(Jblur)
