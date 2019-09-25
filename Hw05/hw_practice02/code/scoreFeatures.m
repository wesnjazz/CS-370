function score = scoreFeatures(x, y)

THREE = 3;
EIGHT = 8;
score = zeros(size(x, 1), size(x, 2));

% loop over all feature pixels of a digit image
for i=1:size(x,1)       % size(x) = 28x28x1x200
    for j=1:size(x,2)   % size(y) = 1:200
        % get indexes of data x splitting by its value of 0, 1
        ind_NO = x(i,j,:,:)==0;
        ind_YES = x(i,j,:,:)==1;

        % get subset of data x
        NO = x(ind_NO);  % subset of data x on which x(i,j) == 0
        YES = x(ind_YES); % subset of data x on which x(i,j) == 1

        % count each subset
        NO_THREE = sum(y(ind_NO)==3);
        NO_EIGHT = sum(y(ind_NO)==8);
        YES_THREE = sum(y(ind_YES)==3);
        YES_EIGHT = sum(y(ind_YES)==8);
        
        % score = #of majority answer(3 or 8) in NO + #of majority answer in YES
        score(i,j) = max(NO_THREE, NO_EIGHT) + max(YES_THREE, YES_EIGHT);
%         if (i==19 && j == 11) || (i==18 && j==12)
%             [i, j]
%             NO_THREE
%             NO_EIGHT
%             YES_THREE
%             YES_EIGHT
%             NO_THREE / (NO_THREE+NO_EIGHT)
%             NO_EIGHT / (NO_THREE+NO_EIGHT)
%             YES_THREE / (YES_THREE+YES_EIGHT)
%             YES_EIGHT / (YES_THREE+YES_EIGHT)
%             (NO_THREE + YES_THREE) / 200
%             (NO_EIGHT + YES_EIGHT) / 200
%         end
    end
end

% get index of the highest score
[max_x, max_y] = find(score==max(max(score)))

