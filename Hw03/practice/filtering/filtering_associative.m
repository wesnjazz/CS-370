
% Often apply several filters one after another: 
% (((a * b 1 ) * b 2 ) * b 3 )
% This is equivalent to applying one filter:
% a * (b 1 * b 2 * b 3 )

% ----------------------------------------------
clear
% set all Figure size to full screen
set(groot, 'defaultFigureUnits','normalized')
set(groot, 'defaultFigurePosition',[0 0 1 1])
% ----------------------------------------------


% rgb image
imcl = imread('parrot.jpg');

% create a filter blur (3x3)
blur = zeros(3,3)
blur(:,:) = 1/9

% create a filter enhance the pixel value (3x3)
enhance = zeros(3,3)
enhance(2,2) = 2

% right shift
right = zeros(3,3)
right(2,1) = 1

% apply filters in order
Jinorder = imfilter(imcl, blur);
Jinorder = imfilter(Jinorder, enhance);
Jinorder = imfilter(Jinorder, right);

Jreverse = imfilter(imcl, right);
Jreverse = imfilter(Jinorder, enhance);
Jreverse = imfilter(Jinorder, blur);

% the filter combined
f_comb = imfilter(blur, enhance);
f_comb = imfilter(f_comb, right)
J_comb = imfilter(imcl, f_comb);

% display
figure
subplot(1, 4, 1)
imshow(imcl)
subplot(1, 4, 2)
imshow(Jinorder)
subplot(1, 4, 3)
imshow(Jreverse)
subplot(1, 4, 4)
imshow(J_comb)


