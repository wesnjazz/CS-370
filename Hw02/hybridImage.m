function H = hybridImage(im1, im2, sigma1, sigma2)
    im1d = im2double(im1);
    im2d = im2double(im2);
    
    filter1 = fspecial('gaussian', 6*sigma1 + 1, sigma1);
    filter2 = fspecial('gaussian', 6*sigma2 + 1, sigma2);

    blurry1 = imfilter(im1d, filter1);
    blurry2 = imfilter(im2d, filter2);

    sharp1 = im1d - blurry1;
    sharp2 = im2d - blurry2;
    
    H = blurry1 + sharp2;
end