function accuracy = KNN(test_x, train_x, y, K)

test_label = [];
for i=1:size(test_x,4)      % for each TEST images
    distances = [];
    for j=1:size(train_x,4)       % for each TRAIN images

        % reshape images into 1D vector to make it easier to calculate the distance
        vec_test = reshape(test_x(:,:,:,i),[1 size(test_x,1)*size(test_x,2)]);
        vec_train = reshape(train_x(:,:,:,j),[1 size(train_x,1)*size(train_x,2)]);
        
        % get the distance
        d = pdist2(double(vec_test), double(vec_train));

        % record all distances from this TEST image to all TRAIN images
        distances = cat(2,distances,d);
    end
    
    % get the K nearest neighbors by finding k minimum distances
    min_d = mink(distances, K);

    % get its indexes
    [tf, loc] = ismember(min_d, distances);

    % get its labels from the TRAIN data
    labels = y(loc);

    % pick its label by seeing the majority of K nearest neighbors
    test_label(i) = mode(labels);
end


% Evaluate the accuracy
correct = sum(y==test_label)
wrong = sum(y~=test_label)
accuracy = correct / (correct + wrong)

end