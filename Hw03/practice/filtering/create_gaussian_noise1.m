but1 = imread('butterfly1.jpg');

% add gaussian noise
Jnoise = imnoise(but1, 'gaussian');

% create gaussian filter
sigma1 = 2;
gausFilter = fspecial('gaussian', 6*sigma1 + 1, sigma1);
Jgaus = imfilter(Jnoise, gausFilter);


% median filter
Jmedian = medfilt2(Jnoise);

figure
subplot(2, 3, 1)
imshow(but1)
title('original');

subplot(2, 3, 2)
imshow(Jnoise)
title('Gaussian noise');

subplot(2, 3, 3)
imshow(Jgaus)
title('Gaussian filter sigma=2');

subplot(2, 3, 4)
imshow(Jmedian)

