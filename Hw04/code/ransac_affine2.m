function [inliers, transf] = ransac_affine(matches, c1, c2)
% This code is part of:
%
%   CMPSCI 370: Computer Vision, Spring 2018
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 4

max_num_inliers = 0;    % record max num of item in inlier
% best_tx = 0;    % record best tx
% best_ty = 0;    % record best ty
% best_scale = 0; % record best scale
best_affine_M = [];
best_translate_M = [];
best_inliers = [];  % record best inliers

N = 10000;    % number of iterations for RANSAC
threshold = 500;  % THRESHOLD

for n = 1:N
    % Select three random indices i, j and h
    i = randi(size(matches,1)); % random index i
    % if matched index to i is zero, then find another
    while matches(i) == 0   
%         rng('shuffle'); % change seed by current time
        i = randi(size(matches, 1));
    end
    j = randi(size(matches,1)); % random index j
    while i == j || matches(j) == 0
%         rng('shuffle');
        j = randi(size(matches,1));
    end
    h = randi(size(matches,1));
    while h == i || h == j || matches(h) == 0
%         rng('shuffle');
        h = randi(size(matches,1));
    end
    
    % Sample three random pairs from im1 and im2
    rand_x1 = c1(1,i);   % x1 (original)
    rand_x1p = c2(1,matches(i)); % x1' (transformed)
    rand_y1 = c1(2,i);
    rand_y1p = c2(2,matches(i));
    rand_x2 = c1(1,j);
    rand_x2p = c2(1,matches(j));
    rand_y2 = c1(2,j);
    rand_y2p = c2(2,matches(j));
    rand_x3 = c1(1,h);   % x1 (original)
    rand_x3p = c2(1,matches(h)); % x1' (transformed)
    rand_y3 = c1(2,h);
    rand_y3p = c2(2,matches(h));

    % matrix of random points
    randpoints_M = [rand_x1 rand_y1 0 0 1 0;
                0 0 rand_x1 rand_y1 0 1;
                rand_x2 rand_y2 0 0 1 0;
                0 0 rand_x2 rand_y2 0 1;
                rand_x3 rand_y3 0 0 1 0;
                0 0 rand_x3 rand_y3 0 1;];
    % matrix of transformed points
    transformed_M = [rand_x1p;
                     rand_y1p;
                     rand_x2p;
                     rand_y2p;
                     rand_x3p;
                     rand_y3p;];
    % matrix of parameters
%     parameter_M = inv(randpoints_M) * transformed_M;
    parameter_M = randpoints_M \ transformed_M;
%     parameter_M = inv(randpoints_M' * randpoints_M) * randpoints_M' * transformed_M;
    
    % Affine matrix / Translate matrix 
    affine_M = [parameter_M(1) parameter_M(2);
                parameter_M(3) parameter_M(4);];
    translate_M = [parameter_M(5);
                   parameter_M(6);];
%     tx = parameter_M(5);
%     ty = parameter_M(6);
            
            
%     % Get transformation T(scale, tx, ty)
%     scale = sqrt( (rand_x1p-rand_x2p)^2 + (rand_y1p-rand_y2p)^2 ) / ...
%             sqrt((rand_x1-rand_x2)^2 + (rand_y1-rand_y2)^2);
%     tx = (rand_x1p+rand_x2p-scale*rand_x1-scale*rand_x2) / 2.0;
%     ty = (rand_y1p+rand_y2p-scale*rand_y1-scale*rand_y2) / 2.0;

    % Calculate every distances using the above transformation
    inliers = [];  % container to record inliers
    for k = 1:size(matches,1)        
        % get a point of corner1 and its matched corner 2
        x1 = c1(1,k);           % get x
        x1p = c2(1,matches(k)); % get matched x
        y1 = c1(2,k);           % get y
        y1p = c2(2,matches(k)); % get matched y

        % Map a predicted transformation point of im2 to im1 using transformation T
%         Tx1p = (x1p-tx)/scale;  % get transformed x of x1p
%         Ty1p = (y1p-ty)/scale;  % get transformed y of y1p
        mapped_M = affine_M * [x1p; y1p] + translate_M;
        Tx1p = mapped_M(1);
        Ty1p = mapped_M(2);
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
        best_affine_M = affine_M;
        best_translate_M = translate_M;
%         best_tx = tx;
%         best_ty = ty;
%         best_scale = scale;
    end

end

% transf = [best_tx, best_ty, best_scale];
transf = [best_affine_M; best_translate_M';];
inliers = best_inliers;
