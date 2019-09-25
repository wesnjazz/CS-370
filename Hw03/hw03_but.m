but = imread('data/butterfly.png');
sigma = 2;
filterG = fspecial('gaussian', 6*sigma + 1, sigma);
butG = imfilter(but, filterG);

[m, a] = imageGradient(but);
[ms, as] = imageGradient(butG);