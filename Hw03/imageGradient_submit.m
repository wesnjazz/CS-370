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
    gx = imfilter(imgd, fx, 'replicate');
    gy = imfilter(imgd, fy, 'replicate');

    % Magnitude
    mag = sqrt(gx.^2 + gy.^2);
    % Angle
    ang = atand(gy./(gx+0.0000000000001)); % added non zero value to avoid divided by 0

    % Make bins for histogram
    [x, y] = size(imgd); % get image size
    bin = zeros([1 9]); % 9 bins
    for i = 1:x
        for j = 1:y
            % add 90 to each degree value to compute bins easier
            e = ang(i, j) + 90;
            % get corresponding bin numbers by modulo 20
            bin_num = idivide(e, uint8(20)) + 1;
            if e == 180
                bin_num = 9; % deal edge case which is 90 degree
            end
            % accumuldate corresponding magnitude per each angle degree values
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

