function C = constructDictionary(x, K, ps)
% x: [h, w, 1, n]

C = zeros(ps, ps, K);

% Decide the boundary: number of pixels that can take in the patch 
% from each direction of LEFT/UPPER or RIGHT/BOTTOM
% LU : LEFTT/UPPER  RB: RIGHT/BOTTOM
LU = floor((ps-1)/2);
if mod(ps,2) == 0  % if patch size ps is even
    RB = floor((ps+1)/2);
else               % if patch size ps is odd
    RB = floor((ps-1)/2);
end

% generate t patches from each image
% loop over each image from TRAIN dataset x
features = [];
for i=1:size(x,4)
    % randomly draw t patches
    t = 20;
    for j=1:t
        % generate random center pixel(a,b)
        % randomized patch's center will be located within boundary of image
        
        % random center pixel
        pixel = randi([1+LU size(x,1)-RB],1,2);

        % get the patch of size ps*ps within the patch boundary
        patch = x(pixel(1)-LU:pixel(1)+RB, pixel(2)-LU:pixel(2)+RB);
    
        % flatten the patch
        patch_flat = reshape(patch, [1 ps*ps]);
        
        % record the extracted patch
        features = cat(1,features,patch_flat);
    end
end

% classify the features(patch) by running kmeans
% loc = kmeans(features, K);
% uloc = unique(loc);

% reshape back the features into original shape and record into C
% for i=1:size(uloc,1)
%     a = reshape(features(uloc(i),:),[ps ps]);
%     C(:,:,i) = a;
% end

[IDX, B] = kmeans(features, K);
B = transpose(double(B));
C = reshape(B, [ps ps K]);




