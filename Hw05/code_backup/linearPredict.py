import numpy as np

def softmax(z):
    return 1.0/(1+np.exp(-z))

def linearPredict(model, x):
    #Add a bias term to the features
    x = np.concatenate((x, np.ones(x.shape[1])[np.newaxis, :]), axis=0)

    prob = softmax(model['weights'].dot(x))
    ypred = np.ones(x.shape[1])*model['classLabels'][1]
    ypred[prob > 0.5] = model['classLabels'][0]

    return ypred
