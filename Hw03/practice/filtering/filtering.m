clear

% set all Figure size to full screen
set(groot, 'defaultFigureUnits','normalized')
set(groot, 'defaultFigurePosition',[0 0 1 1])

% bw image
imbw = imread('low-contrast-bw.png');

% rgb image
imcl = imread('parrot.jpg');

% create a filter blur (3x3)
blur = zeros(3,3)
blur(:,:) = 1/9

% create a filter right shift (3x3)
right = zeros(3,3)
right(2,1) = 1


% apply filters
Jblur = imfilter(imcl, blur);
Jright = imfilter(imcl, right);

% display
figure
subplot(1, 2, 1)
imshow(imcl)
subplot(1, 2, 2)
imshow(Jblur)

figure
subplot(1, 2, 1)
imshow(imcl)
subplot(1, 2, 2)
imshow(Jright)

