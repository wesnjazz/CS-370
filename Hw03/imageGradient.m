function [mag, ang] = imageGradient(im)

    % Convert to grayscale, and convert to double format
    if size(im, 3) > 1
        imgd = double(rgb2gray(im))/255;
    else
        imgd = double(im)/255;
    end
    
    % Gradient filters
    fx = [-1 0 1];
    fy = fx';
    
    % Gradient image of each direction, x and y
%     gx = conv2(imgd, fx, 'same');
%     gy = conv2(imgd, fy, 'same');
    gx = imfilter(imgd, fx, 'replicate');
    gy = imfilter(imgd, fy, 'replicate');

    % Magnitude
    mag = sqrt(gx.^2 + gy.^2);
    % Angle
%     ang = atan2(gy, gx) * (90/pi);
    ang = atand(gy./(gx+0.0000000000001));
%     Hist_ang = discretize(angle, 9);
%     Hist_mag = discretize(mag, 9);
%     [Zang, edges_ang] = histcounts(Hist_ang, 9);
%     [Zmag, edges_mag] = histcounts(Hist_mag, 9);

    [x, y] = size(imgd);
    bin = zeros([1 9]);
    for i = 1:x
        for j = 1:y
            e = ang(i, j) + 90;
            bin_num = idivide(e, uint8(20)) + 1;
            if e == 180
                bin_num = 9;
            end
            bin(1, bin_num) = bin(1, bin_num) + mag(i, j);
                       
        end
    end
    
    figure
    subplot(2, 2, 1);
    imagesc(imgd); colormap(gca, 'gray');
    title('Image');
    subplot(2, 2, 2);
    imagesc(mag); colormap(gca, 'gray');
    title('Gradient magnitude');
    subplot(2, 2, 3);
    imagesc(ang); colormap(gca, 'parula'), colorbar;
    title('Gradient angle');
    subplot(2, 2, 4);
    axis = [1 2 3 4 5 6 7 8 9];
    bar(axis, bin, 'histc');
    xlabel('Bin'); ylabel('Total magnitude');
    title('Gradient histogram');
    
end

