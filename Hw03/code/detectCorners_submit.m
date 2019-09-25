function [cx, cy, cs] = detectCorners(I, isSimple, w, th)
% This code is part of:
%
%   CMPSCI 370: Computer Vision, Spring 2016
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 3

% Convert to double format
I = im2double(I); 

% Convert color to grayscale
if size(I, 3) > 1 
    I = rgb2gray(I);
end

% Step 1: Compute corner score
if isSimple
    cornerScore = simpleScore(I, w);
else
    cornerScore = harrisScore(I, w);
end

% Step 2: Threshold corner score abd find peaks
cornerScore (cornerScore < th) = 0;
[cx, cy, cs] = nms(cornerScore);

%--------------------------------------------------------------------------
%                                    Simple score function (Implement this)
%--------------------------------------------------------------------------
function cornerScore = simpleScore(I, w)
cornerScore = zeros(size(I));

% Gaussian filter
Gsigma = fspecial('gaussian', 6*w+1, w);

for u = -1:1
    for v = -1:1
        if u == 0 && v == 0 % skip itself pixel
            continue;
        end
        imdiff = imfilter(I, filter_uv(u, v), 'replicate');
        cornerScore = cornerScore + imfilter(imdiff.^2, Gsigma, 'replicate');
    end
end



function fuv = filter_uv(u, v)
% Create a filter depends on the argument u, v shifts
  fuv = zeros([3 3]);
  fuv(v+2, u+2) = 1;
  fuv(2, 2) = -1;
  if u == 0 && v == 0
      fuv(2, 2) = 1;
  end

%--------------------------------------------------------------------------
%                                    Harris score function (Implement this)
%--------------------------------------------------------------------------
function cornerScore= harrisScore(I, w)
% cornerScore = 0.000102*rand(size(I)); % Replace this with your implementation

dx = [0 0 0;
      -1 0 1;
      0 0 0;];
dy = [0 1 0;
      0 0 0;
      0 -1 0;];

% Partial derivatives
Ix = imfilter(I, dx, 'replicate');
Iy = imfilter(I, dy, 'replicate');

% Gaussian filter
G = fspecial('gaussian', 6*w+1, w);

% Matrix M
Ix2 = imfilter(Ix.^2, G, 'replicate');
Iy2 = imfilter(Iy.^2, G, 'replicate');
IxIy = imfilter(Ix.*Iy, G, 'replicate');
IyIx = imfilter(Iy.*Ix, G, 'replicate');

k = 0.04;
detM = Ix2.*Iy2 - IxIy.*IyIx; % det(M) = ad - bc
traceM = Ix2 + Iy2; % trace(M) = a + d

cornerScore = detM - k*traceM.*traceM;



