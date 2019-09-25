A = [3 3 3; 4 4 4; 5 5 5]
B = [3 3 4; 4 4 4; 5 5 10]

sum = 0;
for i=1:3
    for j=1:3
        sum = sum + (A(i,j) - B(i,j))^2;
    end
end

sum
sqrt(sum)

flatA = reshape(A,[1 9])
flatB = reshape(B,[1 9])
