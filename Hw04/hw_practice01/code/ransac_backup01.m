function [inliers, transf] = ransac(matches, c1, c2)
% This code is part of:
%
%   CMPSCI 370: Computer Vision, Spring 2018
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 4

% best_m = 0;
% best_b = 0;
num_inliers = 0;
best_inliers = [];
best_tx = 0;
best_ty = 0;
best_scale = 0;
% best_x_inliers = [];


N = 300;
for n = 1:N
    inliers = [];

    % Select two random indices i and j
    i = randi(size(matches,1));
    while matches(i) == 0
        i = randi(size(matches, 1));
    end
    j = randi(size(matches,1));
    while i == j || matches(j) == 0
        j = randi(size(matches,1));
    end

    % Sample two random points from matches
    x1 = c1(1,i);
    x1p = c2(1,matches(i));
    y1 = c1(2,i);
    y1p = c2(2,matches(i));
    x2 = c1(1,j);
    x2p = c2(1,matches(j));
    y2 = c1(2,j);
    y2p = c2(2,matches(j));

    % Get transformation T(scale, tx, ty)
    scale = sqrt((x1p-x2p)^2 + (y1p-y2p)^2) / sqrt((x1-x2)^2 + (y1-y2)^2);
    tx = (x1p+x2p-scale*x1-scale*x2) / 2.0;
    ty = (y1p+y2p-scale*y1-scale*y2) / 2.0;

    % Map a point in im2 to im1 using transformation T
    Tx1p = (x1p - tx) / scale;
    Ty1p = (y1p - ty) / scale;
    
    
    threshold = 15;
    for k = 1:size(matches,1)
    %     if matches(k) == 0
    %         inliers = [inliers 0];
    %         continue;
    %     end

        
        
        m1 = c1(1,k);
        m1p = c2(1,matches(k));
        n1 = c1(2,k);
        n1p = c2(2,matches(k));
        Tm1p = (m1p-tx) / scale;
        Tn1p = (n1p-ty) / scale;
        d = (m1 - Tm1p)^2 + (n1 - Tn1p)^2;
        if d < threshold
            inliers = [inliers matches(k)];
        end
    end

    if numel(inliers) > num_inliers
        best_inliers = inliers;
        num_inliers = numel(inliers);
        best_tx = tx;
        best_ty = ty;
        best_scale = scale;
    end

end

transf = [best_tx best_ty best_scale];


% Get a fitting line, y = mx + b
% m = (p2y - p1y) / (p2x - p1x);
% b = p1y - m*p1x;
% x = [1:size(matches, 1)];
% y = x.*m + b;

% Visualize the fitting line
% figure
% scatter(x, matches')
% hold on;
% scatter(i, p1y, 'filled')
% scatter(j, p2y, 'filled')
% plot(x, y)

% Calculate distance from each points in matches to the fitting line.
% and, add it to inliers if the distance is less than t.
% inliers = [];
% x_inliers = [];
% t = 200;
% for k = 1:size(matches, 1)
%     distance = (y(k) - matches(k))^2;
%     if distance > 0 && distance < t && matches(k) ~= 0
%         inliers = [inliers matches(k)];
%         x_inliers = [x_inliers k];
%     end
% end

% If there are d or more inliers and the number of inliers is higher
% than the previous best, accept the line and refit using all inliers
% d = 50;
% if numel(inliers) >= d && numel(inliers) > num_inliers
%     A = [ones(1, size(x_inliers, 2))' inliers'];
%     new_m = (inv(A'*A))*(A')*(inliers');
%     best_m = new_m(1);
%     best_b = new_m(2);
% %     best_m = m;
% %     best_b = b;
%     num_inliers = numel(inliers);
%     best_inliers = inliers;
%     best_x_inliers = x_inliers;
% end

% end

% transf = [tx ty scale];

% Refit using all inliers
% clear x;
% clear y;
% x = [1:size(matches, 1)];
% y = x.*best_m + best_b;
% figure
% scatter(x, matches')
% hold on;
% scatter(i, matches(i), 'filled')
% scatter(j, matches(j), 'filled')
% plot(x, y)

% size(best_x_inliers)
% ones(1, size(best_x_inliers, 2))
% A = [ones(1, size(best_x_inliers, 2))' best_x_inliers']
% size(A)
% size(A'*A)
% size(inv(A'*A))
% size(A')
% size(best_inliers)
% new_m = (inv(A'*A))*(A')*(best_inliers')

% inliers
% figure
% scatter(best_x_inliers, best_inliers)
% hold on;
% xx = [1:size(matches, 1)];
% yy = xx.*new_m(2) + new_m(1);
% plot(xx, yy)
% 
% [r, m, b] = regression(best_x_inliers, best_inliers)

% x1 = c1(1,i);
% y1 = c1(2,i);
% m = matches(i)
% x1p = c2(1,m);
% y1p = c2(2,m);
% 
% x2 = c1(1,j);
% y2 = c1(2,j);
% n = matches(j)
% x2p = c2(1,n);
% y2p = c2(1,n);
% 
% scale = sqrt((x1p-x2p)^2 + (y1p-y2p)^2) / sqrt((x1-x2)^2 + (y1-y2)^2)
% tx = (x1p + x2p - scale*x1 - scale*x2) / 2.0
% ty = (y1p + y2p - scale*y1 - scale*y2) / 2.0



