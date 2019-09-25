% This code is part of:
%
%   CMPSCI 370: Computer Vision, Spring 2018
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 4

% Read images
close all
im1 = imread('../data/umass_building_left.jpg'); % left image
im2 = imread('../data/umass_building_right4.jpg'); % right image (change this to right2, right3,..., right5)

% Detect corners using harris corner detector
sigma = 1.5;
threshold = 0.0005;
maxCorners = 200;
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
[inliers, transf] = ransac(matches, c1, c2);
goodMatches = zeros(size(matches));
goodMatches(inliers) = matches(inliers);
showMatches(im1, im2, c1, c2, goodMatches);
title('inliers');

% Warp images
stitchIm = mergeImages(im1,im2, transf);
figure;
imshow(stitchIm);
title('stitched image');