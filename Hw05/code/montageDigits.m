function avgImage = montageDigits(x)
numImages = size(x, 4);
nx = 20;
ny = ceil(numImages/nx);
montage(x, 'Size', [ny nx]);

if nargout > 0, %compute avgImg
    avgImage = squeeze(mean(x, 4));
end
