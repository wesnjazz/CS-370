function [inliers, transf] = ransac_affine(matches, c1, c2)
% This code is part of:
%
%   CMPSCI 370: Computer Vision, Spring 2018
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 4

max_num_inliers = 0;    % record max num of item in inlier
best_affine_M = [];     % record best affine matrix M
best_translate_M = [];  % record best translate matrix 
best_inliers = [];      % record best inliers

N = 10000;      % number of iterations for RANSAC
threshold = 1;  % THRESHOLD

for n = 1:N
    % Select three random indices i, j and h
    i = randi(size(matches,1)); % random index i
    % if matched index to i is zero, then find another
    while matches(i) == 0   
        i = randi(size(matches, 1));
    end
    j = randi(size(matches,1)); % random index j
    while i == j || matches(j) == 0
        j = randi(size(matches,1));
    end
    h = randi(size(matches,1)); % random index h
    while h == i || h == j || matches(h) == 0
        h = randi(size(matches,1));
    end
    
    % Sample three random pairs from im1 and im2
    x1 = c1(1,i);               % x1 (original)
    x1p = c2(1,matches(i));     % x1' (transformed)
    y1 = c1(2,i);
    y1p = c2(2,matches(i));
    x2 = c1(1,j);
    x2p = c2(1,matches(j));
    y2 = c1(2,j);
    y2p = c2(2,matches(j));
    x3 = c1(1,h);
    x3p = c2(1,matches(h));
    y3 = c1(2,h);
    y3p = c2(2,matches(h));

    % matrix of random points
    randpoints_M = [x1 y1 0 0 1 0;
                    0 0 x1 y1 0 1;
                    x2 y2 0 0 1 0;
                    0 0 x2 y2 0 1;
                    x3 y3 0 0 1 0;
                    0 0 x3 y3 0 1;];
    % matrix of transformed points
    transformed_M = [x1p;
                     y1p;
                     x2p;
                     y2p;
                     x3p;
                     y3p;];
    % matrix of parameters
    parameter_M = inv(randpoints_M) * transformed_M;

    % Affine matrix and Translate matrix 
    affine_M = [parameter_M(1) parameter_M(2);
                parameter_M(3) parameter_M(4);];
    translate_M = [parameter_M(5);
                   parameter_M(6);];
            
    % Calculate every distances using the above transformation
    inliers = [];  % container to record inliers
    for k = 1:size(matches,1)        
        % get a point of corner1 and its matched corner 2
        x1 = c1(1,k);           % get x
        x1p = c2(1,matches(k)); % get matched x
        y1 = c1(2,k);           % get y
        y1p = c2(2,matches(k)); % get matched y

        % Map a predicted transformation point of im2 to im1 using transformation T
        mapped_M = affine_M * [x1; y1] + translate_M;
        Tx1p = mapped_M(1);
        Ty1p = mapped_M(2);
        d = (x1p - Tx1p)^2 + (y1p - Ty1p)^2; % get distance

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
        best_affine_M = affine_M;
        best_translate_M = translate_M;
    end

end

transf = [best_affine_M; best_translate_M';]
inliers = best_inliers;
