THREE = 3;
EIGHT = 8;

% load data
d = load('data.mat');
x = d.data.train.x;
y = d.data.train.y;
test_x = d.data.test.x;
test_y = d.data.test.y;

% ********** Depth 1 **********
% train the Decision Tree and get the best feature
best_f = DT(x, y);

% apply this rule to the test set
NO = [];
YES = [];
NO_label = [];
YES_label = [];
for i=1:size(test_x,4)
    % if test pixel is 0, then place it into NO and save its location
    if test_x(best_f(1,1),best_f(1,2),1,i)==0
        NO = cat(4,NO,test_x(:,:,:,i));
        NO_label = cat(2,NO_label,test_y(:,i));
    else
    % if test pixel is 1, then place it into YES and save its location
        YES = cat(4,YES,test_x(:,:,:,i));
        YES_label = cat(2,YES_label,test_y(:,i));
    end
end

% Get the accuracy of the test set in Depth 1
acc_test = sum(NO_label==THREE) + sum(YES_label==EIGHT)
num_test = size(test_x,4)
acc_test_pcnt = acc_test / num_test



% ********** Depth 2 **********
% *** subdataset: NO ***
% train the Decision Tree and get the best feature
best_f = DT(NO, NO_label);

% apply this rule to the test set
NO_D2 = [];
YES_D2 = [];
NO_D2_label = [];
YES_D2_label = [];
for i=1:size(NO,4)
    % if test pixel is 0, then place it into NO and save its location
    if NO(best_f(1,1),best_f(1,2),1,i)==0
        NO_D2 = cat(4,NO_D2,NO(:,:,:,i));
        NO_D2_label = cat(2,NO_D2_label,NO_label(:,i));
    else
    % if test pixel is 0, then place it into YES and save its location
        YES_D2 = cat(4,YES_D2,NO(:,:,:,i));
        YES_D2_label = cat(2,YES_D2_label,NO_label(:,i));
    end
end

% Get the accuracy of the test set in Depth 2 -subdata: NO
acc_test_D2_NO = sum(NO_D2_label==THREE) + sum(YES_D2_label==EIGHT)
num_test_D2_NO = size(NO_D2,4) + size(YES_D2,4)
acc_test_D2_NO_pcnt = acc_test_D2_NO / num_test_D2_NO


% ********** Depth 2 **********
% *** subdataset: YES ***
% train the Decision Tree and get the best feature
best_f = DT(YES, YES_label);

% apply this rule to the test set
NO_D2 = [];
YES_D2 = [];
NO_D2_label = [];
YES_D2_label = [];
for i=1:size(YES,4)
    % if test pixel is 0, then place it into NO and save its location
    if YES(best_f(1,1),best_f(1,2),1,i)==0
        NO_D2 = cat(4,NO_D2,YES(:,:,:,i));
        NO_D2_label = cat(2,NO_D2_label,YES_label(:,i));
    else
    % if test pixel is 0, then place it into YES and save its location
        YES_D2 = cat(4,YES_D2,YES(:,:,:,i));
        YES_D2_label = cat(2,YES_D2_label,YES_label(:,i));
    end
end

% Get the accuracy of the test set in Depth 2 -subdata: YES
acc_test_D2_YES = sum(NO_D2_label==EIGHT) + sum(YES_D2_label==THREE)
num_test_D2_YES = size(NO_D2,4) + size(YES_D2,4)
acc_test_D2_YES_pcnt = acc_test_D2_YES / num_test_D2_YES


% ************** Final accuracy in Depth 2 **********************
acc_test_D2_total = acc_test_D2_NO + acc_test_D2_YES
num_test_D2_total = num_test_D2_NO + num_test_D2_YES
acc_test_D2_total_pctn = acc_test_D2_total / num_test_D2_total
