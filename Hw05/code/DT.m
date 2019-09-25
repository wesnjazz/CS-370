function best_f = DT(x, y)

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
score(best_f(1,1), best_f(1,2)) % printf the highest score

end