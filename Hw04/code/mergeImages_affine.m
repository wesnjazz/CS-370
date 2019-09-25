function im = mergeImages_affine(im1, im2, transf)
% This code is part of:
%
%   CMPSCI 370: Computer Vision, Spring 2018
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 4

% Create bigger canvas to merge two images
xmax = uint16(size(im1, 2)*2.5);
ymax = uint16(size(im1, 1)*2.5);
canvas = zeros(ymax, xmax, size(im1,3), 'uint8');

% Get information of affine transformation and translation
affine_M = transf(1:2, 1:2); % 2x2 matrix
translate_M = round(transf(3, :))'; % 2x1 matrix

% Put im1 into the canvas
canvas(1:size(im1, 1), 1:size(im1,2), :) = im1;

% Loop over pixels in canvas, and see if im2 maps into them
for y=1:size(canvas, 1)
    for x=1:size(canvas, 2)
        % calculate transformation
        T_points = affine_M * [x; y] + translate_M;
        xp = round(T_points(1));
        yp = round(T_points(2));
        % copy into canvas if in range of im2
        if xp > 0 && xp < size(im2, 2) && yp > 0 && yp < size(im2, 1)
            canvas(y, x, :) = im2(uint16(yp), uint16(xp), :);
        end
    end
end

im = canvas;
