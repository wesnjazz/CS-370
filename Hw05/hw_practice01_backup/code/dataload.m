% Decision Tree
d = load('data.mat');
train = d.data.train;
test = d.data.test;
x = train.x;
y = train.y;
test_x = test.x;
test_y = test.y;

% Linear Classifier
xrs = reshape(x, 28*28, 200);
