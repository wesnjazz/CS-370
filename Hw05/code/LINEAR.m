% load data
d = load('data.mat');
x = d.data.train.x;
y = d.data.train.y;
test_x = d.data.test.x;
test_y = d.data.test.y;

% ***** Train the model *****
% Reshape the training data
xrs = reshape(x, 28*28, 200);

% Get a model by training with the train data set
model = linearTrain(xrs, y);


% ***** Evaluate the model *****
% Reshape the test data
xrs_test = reshape(test_x, 28*28, 200);

% Get a prediction with test data
ypred = linearPredict(model, xrs_test);

% Calculate the accuracy
predict_correct = sum(ypred == test_y)
predict_wrong = sum(ypred ~= test_y)
accuracy = predict_correct / (predict_correct + predict_wrong)



% ***** Visualization *****
w = model.w(1:end-1);
wp = w.*(w>0);
wn = -w.*(w<0);
subplot(1,2,1);
imagesc(reshape(wp, [28 28])); colormap gray; axis image
title('Weight Positive')
subplot(1,2,2);
imagesc(reshape(wn, [28 28])); colormap gray; axis image
title('Weight Negative')
