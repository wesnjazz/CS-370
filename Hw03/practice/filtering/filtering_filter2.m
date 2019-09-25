
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
Jfull = filter2(enhance, imcl, 'full');
Jsame = filter2(enhance, imcl, 'same');
Jvalid = filter2(enhance, imcl, 'valid');

% display
figure
subplot(1, 4, 1)
imshow(imcl)
subplot(1, 4, 2)
imshow(Jfull)
subplot(1, 4, 3)
imshow(Jsame)
subplot(1, 4, 4)
imshow(Jvalid)


