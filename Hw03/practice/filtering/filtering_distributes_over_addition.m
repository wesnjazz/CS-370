% Distributes over addition
% a * (b + c) = (a * b) + (a * c)

clear

% set all Figure size to full screen
set(groot, 'defaultFigureUnits','normalized')
set(groot, 'defaultFigurePosition',[0 0 1 1])

% rgb image
imcl = imread('parrot.jpg');

% create a filter blur (3x3)
blur = zeros(3,3)
blur(:,:) = 1/9

% create a filter enhance the pixel value (3x3)
enhance = zeros(3,3)
enhance(2,2) = 2

% liearn filter: blur + enhance
linear = blur + enhance

% apply filters
Jblur = imfilter(imcl, blur);
Jenhance = imfilter(imcl, enhance);
Jlinear = imfilter(imcl, linear);

% a * (b + c) = (a * b) + (a * c)
Jdistrib_over_addition = imfilter(imcl, blur);
Jdistrib_over_addition = Jdistrib_over_addition + imfilter(Jdistrib_over_addition, enhance);

% display
figure
subplot(1, 5, 1)
imshow(imcl)
subplot(1, 5, 2)
imshow(Jblur)
subplot(1, 5, 3)
imshow(Jenhance)
subplot(1, 5, 4)
imshow(Jlinear)
subplot(1, 5, 5)
imshow(Jdistrib_over_addition)

