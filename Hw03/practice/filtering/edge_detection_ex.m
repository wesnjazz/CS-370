im = checkerboard(20);

% Prewitt filters
fx = [-1 0 1;
      -1 0 1;
      -1 0 1;];
fy = fx';

% Convolution
gx = conv2(im, fx, 'same');
gy = conv2(im, fy, 'same');

% Display image
figure(1); clf;
subplot(2, 2, 1);
imagesc(im);
title('image');

subplot(2, 2, 2);
imagesc(gx); colormap gray
title('gx');

subplot(2, 2, 3);
imagesc(gy);
title('gy');

subplot(2, 2, 4);
imagesc(gx.^2 + gy.^2);
title('edge magnitude');
