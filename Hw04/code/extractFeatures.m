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
im = padarray(im, [patchRadius patchRadius], 'replicate', 'both');
c(1,:) = patchRadius + c(1,:); % move x axis by patchRadius
c(2,:) = patchRadius + c(2,:); % move y axis by patchRadius

% Create feature container
f = zeros([(2*patchRadius+1)^2 size(c,2)]);

% Extract features on each corners
for i = 1:size(c, 2)
    cornerX = c(1, i);
    cornerY = c(2, i);
    feature = im(cornerY-patchRadius: cornerY+patchRadius, ...
                 cornerX-patchRadius: cornerX+patchRadius);
    feature = feature(:);
    f(:,i) = feature;
end