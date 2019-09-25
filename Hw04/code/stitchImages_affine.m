% This code is part of:
%
%   CMPSCI 370: Computer Vision, Spring 2018
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 4

% Read images
close all
clear
% im1 = imread('../extra_credit/crack01.JPG'); % left image
% im2 = imread('../extra_credit/crack03.JPG'); % right image (change this to right2, right3,..., right5)
% im1 = imread('../extra_credit/calrec01.JPG'); % left image
% im2 = imread('../extra_credit/calrec03.JPG'); % right image (change this to right2, right3,..., right5)
% im1 = imread('../extra_credit/com01.JPG');
% im2 = imread('../extra_credit/com02.JPG');
% im1 = imread('../extra_credit/IMG_8144.JPG');
% im2 = imread('../extra_credit/IMG_8145.JPG');
im1 = imread('../data/umass_building_left.jpg');
im2 = imread('../data/umass_building_right5.jpg');
% im1 = imread('../extra_credit/extra01.JPG');
% im2 = imread('../extra_credit/extra02.JPG');
% im1 = imread('../extra_credit/room01.JPG');
% im2 = imread('../extra_credit/room04.JPG');


% Detect corners using harris corner detector
sigma = 3.5;
threshold = 0.0005;
maxCorners = 300;
isSimple = false;
c1 = detectCorners(im1, isSimple, sigma, threshold);
c2 = detectCorners(im2, isSimple, sigma, threshold);
n1 = min(maxCorners, size(c1,2));
c1 = c1(:,1:n1);
n2 = min(maxCorners, size(c2,2));
c2 = c2(:,1:n2);

% Compute feature descriptors
patchRadius = 5;
f1 = extractFeatures(im1, c1, patchRadius);
f2 = extractFeatures(im2, c2, patchRadius);


% Compute matches
matches = computeMatches(f1,f2);
showMatches(im1, im2, c1, c2, matches);
title('all matches');

% Estimate transformation
[inliers, transf] = ransac_affine(matches, c1, c2);
goodMatches = zeros(size(matches));
goodMatches(inliers) = matches(inliers);
showMatches(im1, im2, c1, c2, goodMatches);
title('inliers');

% Warp images
stitchIm = mergeImages_affine(im1,im2, transf);
figure;
imshow(stitchIm);
title('stitched image');