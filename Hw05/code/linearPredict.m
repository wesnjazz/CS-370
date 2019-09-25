function ypred = linearPredict(model,x)
% Add a bias term
x = cat(1, x, ones(1, size(x,2)));
prob = softmax(model.w*x);
ypred = ones(1,size(x,2))*model.classLabels(2);
ypred(prob > 0.5) = model.classLabels(1);

function sz = softmax(z)
sz = 1./(1+exp(-z));
