function c = detectCorners(I, isSimple, w, th)

% Convert to double format
I = im2double(I); 

% Convert color to grayscale
if size(I, 3) > 1 
    I = rgb2gray(I);
end

% Step 1: Compute corner score
if isSimple
    cornerScore = simpleScore(I, w);
else
    cornerScore = harrisScore(I, w);
end

% Step 2: Threshold corner score abd find peaks
cornerScore (cornerScore < th) = 0;
[cx, cy, cs] = nms(cornerScore);
c = [cx'; cy'; cs'];
isvalid = cx > 0 & cx <= size(I,2) & cy > 0 & cy <= size(I,1);
c = c(:,isvalid);


%--------------------------------------------------------------------------
%                                    Simple score function (Implement this)
%--------------------------------------------------------------------------
function cornerScore = simpleScore(I, w)
%cornerScore = rand(size(I)); % Replace this with your implementation

gs = fspecial('Gaussian', 6*w+1, w);

f{1} = [1 0 0; 0 -1 0; 0 0 0];
f{2} = [0 1 0; 0 -1 0; 0 0 0];
f{3} = [0 0 1; 0 -1 0; 0 0 0];
f{4} = [0 0 0; 1 -1 0; 0 0 0];
f{5} = [0 0 0; 0 -1 1; 0 0 0];
f{6} = [0 0 0; 0 -1 0; 1 0 0];
f{7} = [0 0 0; 0 -1 0; 0 1 0];
f{8} = [0 0 0; 0 -1 0; 0 0 1];

cornerScore = zeros(size(I));
for i = 1:8, 
    diff = imfilter(I, f{i}, 'replicate', 'same');
    diffSum = imfilter(diff.^2, gs, 'replicate', 'same');
    cornerScore = cornerScore + diffSum;
end


%--------------------------------------------------------------------------
%                                    Harris score function (Implement this)
%--------------------------------------------------------------------------
function cornerScore = harrisScore(I, w)
gx = [-1 0 1];
gy = gx';
imgx = imfilter(I, gx, 'replicate', 'same');
imgy = imfilter(I, gy, 'replicate', 'same');

gs = fspecial('Gaussian', 6*w+1, w);

imgx2 = imfilter(imgx.^2, gs, 'replicate', 'same');
imgy2 = imfilter(imgy.^2, gs, 'replicate', 'same');
imgxgy = imfilter(imgx.*imgy, gs, 'replicate','same');
cornerScore = (imgx2.*imgy2 - imgxgy.*imgxgy) - 0.04*(imgx2 + imgy2).^2;
