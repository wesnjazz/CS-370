clear
load('data')
% convert the training data to float
x = single(data.train.x);

K = 100;
patchSize = 9;

% construct the dictionary
C = constructDictionary(x, K, patchSize);

% visualize the dictionary
montageDigits(reshape(C, patchSize, patchSize, 1, K));

% encode all images in training set
x_train = zeros(K, size(x, 4));
for i=1:size(x, 4)
    x_train(:, i) = encodeImage(squeeze(x(:,:,1,i)), C);
end

% train a linear model
model = linearTrain (x_train, data.train.y);

% encode all images in test set
v = single(data.test.x);
x_test = zeros(K, size(v, 4));
for i=1:size(v, 4)
    x_test(:, i) = encodeImage(squeeze(v(:,:,1,i)), C);
end

% make the prediction
ypred = linearPredict(model, x_test);

% evaluate the model
acc = sum(data.test.y == ypred) / size(v, 4);
fprintf('Accuracy on test set: %.3f\n', acc);
