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


% imshow(im); axis image off; hold on;
% plot(c(1,:), c(2,:), 'r.', 'MarkerSize', 20);
% plot(168+5, 71+5, 'g.', 'MarkerSize', 10);

% x = c(1,1)
% y = c(2,1)
% feature = im(x-patchRadius:x+patchRadius, y-patchRadius:y+patchRadius);
% figure(2)
% imshow(feature)
% im(x, y)
% feature = feature(:)
% size(feature)
% size(c, 2)

f = zeros([(2*patchRadius+1)^2 size(c,2)]);
% size(f)

for i = 1:size(c, 2)
    cornerX = c(1, i);
    cornerY = c(2, i);
%     cornerX
%     cornerY
%     cornerX-patchRadius
%     cornerX+patchRadius
%     cornerY-patchRadius
%     cornerY+patchRadius
    feature = im(cornerY-patchRadius: cornerY+patchRadius, ...
                 cornerX-patchRadius: cornerX+patchRadius);
%     figure()
%     imshow(feature)
%     size(feature)
    feature = feature(:);
%     f = [f feature];
    f(:,i) = feature;
end


