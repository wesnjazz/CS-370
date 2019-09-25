
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

% apply filters
Jclip = imfilter(imcl, enhance, 0);
Jwrap = imfilter(imcl, enhance, 'circular');
Jcopy = imfilter(imcl, enhance, 'replicate');
Jreflect = imfilter(imcl, enhance, 'symmetric');

% display
figure
subplot(1, 5, 1)
imshow(imcl)
subplot(1, 5, 2)
imshow(Jclip)
subplot(1, 5, 3)
imshow(Jwrap)
subplot(1, 5, 4)
imshow(Jcopy)
subplot(1, 5, 5)
imshow(Jreflect)


