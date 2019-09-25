function im = mergeImages(im1, im2, transf)
% This code is part of:
%
%   CMPSCI 370: Computer Vision, Spring 2018
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 4
s = transf(3);
tx = round(transf(1)/s); 
ty = round(transf(2)/s);

im2 = imresize(im2, 1/s);

[h1, w1, ~] = size(im1);
[h2, w2, ~] = size(im2);

% Coordinates of the four corners of the images
c1 = [1 w1 w1 1; 1 1 h1 h1];
c2 = [1 w2 w2 1; 1 1 h2 h2];

% Transformed coordinates
c2(1,:) = c2(1,:) - tx;
c2(2,:) = c2(2,:) - ty;

% Get new bounds
xmin = min(1, min(c2(1,:)));
xmax = max(w1, max(c2(1,:)));
ymin = min(1, min(c2(2,:)));
ymax = max(h1, max(c2(2,:)));

im = zeros(ymax - ymin + 1, xmax - xmin + 1, size(im1,3), 'uint8');
ox = max(0, -xmin+1);
oy = max(0, -ymin+1);

% Paste the two images
im(oy+(1:h1), ox+(1:w1),:) = im1;
im(oy+(c2(2,1):c2(2,4)),ox+(c2(1,1):c2(1,2)),:) = im2;

