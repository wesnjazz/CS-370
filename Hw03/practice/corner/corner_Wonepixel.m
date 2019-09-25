im = checkerboard(20);

fx = [0 0 0;
     0 -1 1;
     0 0 0;];
fy = [0 0 0;
      0 -1 0;
      0 1 0;];
fy2 = [0 0 0;
       0 1 0;
       0 -1 0;];
fy3 = [-1 -1 -1;
        0 0 0;
        1 1 1;];
D = [1 0];

J = imfilter(im, fx, 'same');
K = imfilter(im, fy, 'same');
L = imfilter(im, fy2, 'same');
M = imfilter(im, fy3, 'same');

figure
subplot(3, 3, 1);
imshow(im);
subplot(3, 3, 2);
imshow(J);
subplot(3, 3, 3);
imshow(K);
subplot(3, 3, 4);
imshow(L);
subplot(3, 3, 5);
imshow(M);
