% This code is part of:
%
%   CMPSCI 370: Computer Vision, Spring 2016
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 3

% Entry code for corner detector

% Create a checkerboard of size 20 pixels%
% I = checkerboard(20);
% I = imread('../data/polymer-science-umass.jpg');
% I = imread('../corner01.png');
% I = imread('../corner07.jpg');
% I = imread('../data/building06.jpg');
% I = imread('../data/box01.jpeg');
% I = imread('../data/shoes01.jpg');
% I = imread('../data/flight01.jpg');
I = imread('../data/furniture01.jpg');

% Simple corners
[cx, cy, cs] = detectCorners(I, true, 1.5, 0.05);
% [cx, cy, cs] = detectCorners(I, true, 1.5, 0.35);

% Top100 = maxk(cs, 200)
% val100th = Top100(end)
% cx(cs < val100th) = 0;
% cy(cs < val100th) = 0;

% figure;
% subplot(1,2,1);
% imshow(I); axis image off; hold on;
% h = plot(cx, cy, 'r.', 'MarkerSize', 20);
% title('Simple corners');

% hgsave(h,sprintf('checker_simple_corner.png'));

% Harris corners
[cx, cy, cs] = detectCorners(I, false,1.5, 0.0001);

% Top100 = maxk(cs, 100)
% val100th = Top100(end)
% cx(cs < val100th) = 0;
% cy(cs < val100th) = 0;

% subplot(1,2,2);
% imshow(I); axis image off; hold on;
% plot(cx, cy, 'g.', 'MarkerSize', 20);
% title('Harris corners');
