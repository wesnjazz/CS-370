function corner_algorithm(I, W, T)
    score = zeros(size(I));
    f = [0 0 0;
         0 -1 1;
         0 0 0;];
%     f2 = [0 0 0;
%          0 1 -1;
%          0 0 0;];

    D = imfilter(I, f, 'same');
%     D2 = imfilter(I, f2, 'same');
    
%     imshowpair(D, D2, 'montage')


    box = (1/9) * [1 1 1; 1 1 1; 1 1 1];
    Ds = D.^2;
    
    for u = -1:1
        for v = -1:1
%             imdiff = imfilter(I, filter_uv(I, u, v), 'same');
            imdiff = imfilter(I, fspecial('gaussian', 6*2+1, 2), 'same');
            size(score)
            size(ones(W))
            score = score + imfilter(imdiff.^2, ones(W), 'same');
        end
    end
    
    score = nms(score > T);
    locs = find(score > 0);
    [cy, cx] = ind2sub(size(score), lots);
    
    
end