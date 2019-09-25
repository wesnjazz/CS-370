function m = computeMatches(f1,f2)
% This code is part of:
%
%   CMPSCI 370: Computer Vision, Spring 2018
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 4

m = [];
for i = 1 : size(f1, 2)
    % Sum of Squared Difference(ssd)
    % minimum ssd and its index
    ssd_min1 = inf;
    ind_min1 = 0;
%     dotbest = 0;
    % second minimum ssd and its index
%     ssd_min2 = inf;
%     ind_min2 = 0;
    for j = 1 : size(f2, 2)
        diff = f1(:,i) - f2(:,j);
%         dotproduct = dot(f1(:,i), f2(:,j));
%         dotproduct = sum(conj(f1(:,i).*f2(:,j)));
        
%         if dotproduct > dotbest
%             dotbest = dotproduct;
%             ind_min1 = j;
%         end
        
        ssd = sum(diff(:).^2);
        if ssd < ssd_min1
%             ssd_min2 = ssd_min1;
%             ind_min2 = ind_min1;
            ssd_min1 = ssd;
            ind_min1 = j;
        end
%         if ssd > ssd_min1 && ssd < ssd_min2
%             ssd_min2 =ssd;
%             ind_min2 = j;
%         end
    end
%     ratio = ssd_min1 / ssd_min2;
%     if ratio < 0.8
%     m = [m; ind_min1];
    m(i) = ind_min1;
%     else
%         m = [m; 0];
%     end
%     size(m)
end