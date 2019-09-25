% Read images
close all
% im1 = imread('../data/umass_building_left.jpg'); % left image
% im2 = imread('../data/umass_building_right4.jpg'); % right image (change this to right2, right3,..., right5)
im1 = [9 0 1 2 3 0 5 6 1;
       0 1 4 2 9 2 0 0 0;
       2 2 5 5 6 6 2 2 9;
       8 7 6 5 0 0 0 1 2;
       8 9 7 7 7 9 9 9 7;]
im2 = [0 1 2 3 0 5 6 1 8;
       1 4 2 9 2 0 0 0 8;
       2 5 5 6 6 2 2 9 8;
       7 6 5 0 0 0 1 2 8;
       9 7 7 7 9 9 9 7 8;]



% Detect corners using harris corner detector
sigma = 1.5;
threshold = 0.0005;
maxCorners = 200;
isSimple = false;
c1 = detectCorners(im1, isSimple, sigma, threshold);
c2 = detectCorners(im2, isSimple, sigma, threshold);
n1 = min(maxCorners, size(c1,2))
c1 = c1(:,1:n1)
n2 = min(maxCorners, size(c2,2))
c2 = c2(:,1:n2)

% Compute feature descriptors
patchRadius = 5;
f1 = extractFeatures(im1, c1, patchRadius);






function f = extractFeatures(im, c, patchRadius)
% This code is part of:
%
%   CMPSCI 370: Computer Vision, Spring 2018
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 4

% Convert color image to gray
if size(im, 3) > 1 
    im = rgb2gray(im);
end

% Pad image by radius patchRadius pixels
impad = padarray(im, [patchRadius patchRadius], 'replicate', 'both');
c(1,:) = patchRadius + c(1,:); % move x axis by patchRadius
c(2,:) = patchRadius + c(2,:); % move y axis by patchRadius

imshow(impad); axis image off; hold on;
plot(c(1,:), c(2,:), 'r.', 'MarkerSize', 20);
end
