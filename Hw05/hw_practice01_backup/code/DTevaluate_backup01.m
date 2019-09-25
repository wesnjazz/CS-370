THREE = 3;
EIGHT = 8;

% load data
d = load('data.mat');
x = d.data.train.x;
y = d.data.train.y;
test_x = d.data.test.x;
test_y = d.data.test.y;

% ********** Depth 1 **********
% get score of 28*28 matrix
score = scoreFeatures(x, y);

% visualize the score
subplot(2,2,1:2)
imagesc(score); colormap gray; axis image

% get best predict feature
[max_x, max_y] = find(score==max(max(score)));

% print the coordiante of the best feature and its score
best_f = [max_x, max_y];
best_f = [best_f(1,1), best_f(1,2)] % If there is a tie, pick one arbitrarily.
score(best_f(1,1), best_f(1,2))

% apply this rule to the test set
NO = [];
YES = [];
NO_label = [];
YES_label = [];
% NO_test_x = [];
% YES_test_x = [];
for i=1:size(test_x,4)
    if test_x(best_f(1,1),best_f(1,2),1,i)==0
        NO = cat(4,NO,test_x(:,:,:,i));
        NO_label = cat(2,NO_label,test_y(:,i));
%         NO_test_x = cat(4,NO_test_x,test_x(:,:,:,i));
    else
        YES = cat(4,YES,test_x(:,:,:,i));
        YES_label = cat(2,YES_label,test_y(:,i));
%         YES_test_x = cat(4,YES_test_x,test_x(:,:,:,i));
    end
end

% Get the accuracy of the test set
acc_test = sum(NO_label==THREE) + sum(YES_label==EIGHT)
num_test = size(test_x,4)
acc_test_pcnt = acc_test / num_test


% ********** Depth 2 **********
% *** subdataset: NO ***
% get score
score = scoreFeatures(NO, NO_label);
subplot(2,2,3)
imagesc(score); colormap gray; axis image
% get best predict feature
[max_x, max_y] = find(score==max(max(score)));
% print the coordiante of the best feature and its score
best_f = [max_x, max_y];
best_f = [best_f(1,1), best_f(1,2)] % If there is a tie, pick one arbitrarily.
score(best_f(1,1), best_f(1,2))

% apply this rule to the test set
NO_D2 = [];
YES_D2 = [];
NO_D2_label = [];
YES_D2_label = [];
for i=1:size(NO,4)
    if NO(best_f(1,1),best_f(1,2),1,i)==0
        NO_D2 = cat(4,NO_D2,NO(:,:,:,i));
        NO_D2_label = cat(2,NO_D2_label,NO_label(:,i));
    else
        YES_D2 = cat(4,YES_D2,NO(:,:,:,i));
        YES_D2_label = cat(2,YES_D2_label,NO_label(:,i));
    end
end

% Get the accuracy of the test set
acc_test_D2_NO = sum(NO_D2_label==THREE) + sum(YES_D2_label==EIGHT)
num_test_D2_NO = size(NO_D2,4) + size(YES_D2,4)
acc_test_D2_NO_pcnt = acc_test_D2_NO / num_test_D2_NO


% *** subdataset: YES ***
% get score
score = scoreFeatures(YES, YES_label);
subplot(2,2,4)
imagesc(score); colormap gray; axis image
% get best predict feature
[max_x, max_y] = find(score==max(max(score)));
% print the coordiante of the best feature and its score
best_f = [max_x, max_y];
best_f = [best_f(1,1), best_f(1,2)] % If there is a tie, pick one arbitrarily.
score(best_f(1,1), best_f(1,2))

% apply this rule to the test set
NO_D2 = [];
YES_D2 = [];
NO_D2_label = [];
YES_D2_label = [];
for i=1:size(YES,4)
    if YES(best_f(1,1),best_f(1,2),1,i)==0
        NO_D2 = cat(4,NO_D2,YES(:,:,:,i));
        NO_D2_label = cat(2,NO_D2_label,YES_label(:,i));
    else
        YES_D2 = cat(4,YES_D2,YES(:,:,:,i));
        YES_D2_label = cat(2,YES_D2_label,YES_label(:,i));
    end
end

% Get the accuracy of the test set
acc_test_D2_YES = sum(NO_D2_label==EIGHT) + sum(YES_D2_label==THREE)
num_test_D2_YES = size(NO_D2,4) + size(YES_D2,4)
acc_test_D2_YES_pcnt = acc_test_D2_YES / num_test_D2_YES


% ************** Final accuracy **********************
acc_test_D2_total = acc_test_D2_NO + acc_test_D2_YES
num_test_D2_total = num_test_D2_NO + num_test_D2_YES
acc_test_D2_total_pctn = acc_test_D2_total / num_test_D2_total
