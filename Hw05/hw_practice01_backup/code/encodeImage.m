function y = encodeImage(im, C)

y = ones(size(C, 3), 1);

% get patch size
ps = size(C,1);

% Decide the boundary: number of pixels that can take in the patch 
% from each direction of LEFT/UPPER or RIGHT/BOTTOM
% LU : LEFTT/UPPER  RB: RIGHT/BOTTOM
LU = floor((ps-1)/2);
if mod(ps,2) == 0  % if patch size ps is even
    RB = floor((ps+1)/2);
else               % if patch size ps is odd
    RB = floor((ps-1)/2);
end

% loop over all pixels in im
for i=LU+1:size(im,1)-RB
    for j=LU+1:size(im,2)-RB

        % get a patch within the boundary and convert it to double
        patch = im(i-LU:i+RB, j-LU:j+RB);
        patch = double(patch);

        % variable to save least SSD(Sumof-Squared-Distance) and its location
        least_dist = inf;
        least_loc = 0;

        % loop over all feature in C and find the least SSD
        for k=1:size(C,3)
            dist = pdist2(reshape(patch, [1 ps*ps]), reshape(C(:,:,k), [1 ps*ps]));
            if dist < least_dist
                least_dist = dist;
                least_loc = k;
            end
        end
        
        % increase the histogram
        y(least_loc) = y(least_loc) + 1;
    end
end

end
