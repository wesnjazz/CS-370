function m = computeMatches(f1,f2)
% This code is part of:
%
%   CMPSCI 370: Computer Vision, Spring 2018
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 4

% Create matcher container m
m = zeros(size(f1, 2), 1);

% Compute matches using Sum of Square Difference (ssd)
for i = 1 : size(f1, 2)
    % minimum ssd and its index
    ssd_min = inf;
    ind_min = 0;

    % find matches of f2 for a feature of f1
    for j = 1 : size(f2, 2)
        diff = f1(:,i) - f2(:,j);   % difference
        ssd = sum(diff(:).^2);      % ssd
        if ssd < ssd_min        % if this ssd is less than previous
            ssd_min = ssd;      % record ssd
            ind_min = j;        % record its index
        end
    end
    m(i) = ind_min;     % record the index to matches
end