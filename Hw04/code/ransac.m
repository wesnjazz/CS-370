function [inliers, transf] = ransac(matches, c1, c2)
% This code is part of:
%
%   CMPSCI 370: Computer Vision, Spring 2018
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 4

max_num_inliers = 0;    % record max num of item in inlier
best_tx = 0;            % record best tx
best_ty = 0;            % record best ty
best_scale = 0;         % record best scale
best_inliers = [];      % record best inliers

N = 10000;              % number of iterations for RANSAC
threshold = 100;        % THRESHOLD

for n = 1:N
    % Select two random indices i and j
    i = randi(size(matches,1)); % random index i
    % if matched index to i is zero, then find another
    while matches(i) == 0
        i = randi(size(matches, 1));
    end
    j = randi(size(matches,1)); % random index j
    while i == j || matches(j) == 0
        j = randi(size(matches,1));
    end

    % Sample two random pairs from im1 and im2
    x1 = c1(1,i);              % x1 (original)
    x1p = c2(1,matches(i));    % x1' (transformed)
    y1 = c1(2,i);
    y1p = c2(2,matches(i));
    x2 = c1(1,j);
    x2p = c2(1,matches(j));
    y2 = c1(2,j);
    y2p = c2(2,matches(j));

    % Get transformation T(scale, tx, ty)
    scale = sqrt( (x1p-x2p)^2 + (y1p-y2p)^2 ) / ...
            sqrt((x1-x2)^2 + (y1-y2)^2);
    tx = (x1p+x2p-scale*x1-scale*x2) / 2.0;
    ty = (y1p+y2p-scale*y1-scale*y2) / 2.0;

    % Calculate every distances using the above transformation
    inliers = [];                   % container to record inliers
    for k = 1:size(matches,1)        
        % get a point of corner1 and its matched corner 2
        x1 = c1(1,k);               % get x
        x1p = c2(1,matches(k));     % get matched x
        y1 = c1(2,k);               % get y
        y1p = c2(2,matches(k));     % get matched y

        % Map a predicted transformation point of im2 to im1 using transformation T
        Tx1p = (x1p-tx)/scale;      % get transformed x of x1p
        Ty1p = (y1p-ty)/scale;      % get transformed y of y1p
        d = (x1 - Tx1p)^2 + (y1 - Ty1p)^2; % get distance

        % if the distance d is less than THRESHOLD, put into inliers
        if d < threshold
            inliers = [inliers k];
        end
    end

    % if number of inliers is greater than previous one,
    % then, accept this new inliers as the best inliers
    % also record best transformation - tx, ty, scale
    if numel(inliers) > max_num_inliers
        max_num_inliers = numel(inliers);
        best_inliers = inliers;
        best_tx = tx;
        best_ty = ty;
        best_scale = scale;
    end

end

transf = [best_tx, best_ty, best_scale];
inliers = best_inliers;
