function model = linearTrain(x, y)
% Training parameters
param.maxiter = 50;
param.lambda = 0.01;
param.eta = 0.01;

% Add a bias term to the features
x = cat(1, x, ones(1, size(x,2)));

classLabels = unique(y);
numClass = length(classLabels);
assert(numClass == 2); % Binary labels
numFeats = size(x,1);
numData = size(x,2);

trueProb = zeros(1, numData);
trueProb(y == classLabels(1)) = 1;

% Initialize weights randomly
model.w = randn(1, numFeats)*0.01;

% Batch gradient descent
verboseOutput = false;
for iter = 1:param.maxiter,
    prob = softmax(model.w*x);
    delta = (trueProb - prob);
    gradL = delta*x'; 
    model.w = (1-param.eta*param.lambda)*model.w + param.eta*gradL;
end
model.classLabels = classLabels;

function sz = softmax(z)
sz = 1./(1+exp(-z));