THREE = 3;
EIGHT = 8;

% load data
d = load('data.mat');
x = d.data.train.x;
y = d.data.train.y;
test_x = d.data.test.x;
test_y = d.data.test.y;

% Run KNN by different Ks
accuray_K1 = KNN(test_x, x, y, 1);
accuray_K3 = KNN(test_x, x, y, 3);
accuray_K5 = KNN(test_x, x, y, 5);
accuracy = [accuray_K1; accuray_K3; accuray_K5];

% Plot the accuracy
figure()
scatter([1;3;5], accuracy, 1300, 'r', '.'); ylim([0.9 1]); xlim([0 6])
xlabel('K')
ylabel('accuracy')
title('KNN accuracy')