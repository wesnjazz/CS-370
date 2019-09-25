function [L, C] = grayworld (I)
%     I = im2double(I);
    r_avg = mean2(I(:,:,1))
    g_avg = mean2(I(:,:,2))
    b_avg = mean2(I(:,:,3))
    
%     L = [ r_avg/0.5, g_avg/0.5, b_avg/0.5]
    L = [ r_avg/128, g_avg/128, b_avg/128]

    C(:,:,1) = I(:,:,1).*(L(1)^(-1));
    C(:,:,2) = I(:,:,2).*(L(2)^(-1));
    C(:,:,3) = I(:,:,3).*(L(3)^(-1));
end