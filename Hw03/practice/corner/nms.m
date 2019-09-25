function [cx, cy, cs] = nms(cornerScore)
% This code is part of:
%
%   CMPSCI 370: Computer Vision, Spring 2016
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 3

% Pick local maxima
locs = imregionalmax(cornerScore, 8);

% Shrink connected components to one point
locs = bwmorph(locs, 'shrink', Inf);

% Zero out everything else
cornerScore = cornerScore.*locs;

% Convert binary image to a sorted list of locations
locinds = find(locs);
[cy, cx] = ind2sub(size(locs), locinds);
cs = cornerScore(locinds);
[~,ord] = sort(cs, 'descend');
cs = cs(ord);
cx = cx(ord);
cy = cy(ord);