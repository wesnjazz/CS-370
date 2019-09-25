import numpy as np

def softmax(z):
    return 1.0/(1+np.exp(-z))

def linearTrain(x, y):
    #Training parameters
    maxiter = 50
    lamb = 0.01
    eta = 0.01
    
    #Add a bias term to the features
    x = np.concatenate((x, np.ones(x.shape[1])[np.newaxis, :]), axis=0)
    
    class_labels = np.unique(y)
    num_class = class_labels.shape[0]
    assert(num_class == 2) #Binary labels
    num_feats = x.shape[0]
    num_data = x.shape[1]
    
    true_prob = np.zeros(num_data)
    true_prob[y == class_labels[0]] = 1
    
    #Initialize weights randomly
    model = {}
    model['weights'] = np.random.randn(num_feats)*0.01
    
    #Batch gradient descent
    verbose_output = False
    for it in xrange(maxiter):
        prob = softmax(model['weights'].dot(x))
        delta = true_prob - prob
        gradL = delta.dot(x.T)
        model['weights'] = (1 - eta*lamb)*model['weights'] + eta*gradL
    model['classLabels'] = class_labels

    return model
    
