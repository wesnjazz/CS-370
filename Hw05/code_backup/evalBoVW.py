import numpy as np
import matplotlib.pyplot as plt
import utils
from constructDictionary import constructDictionary
from encodeImage import encodeImage
from montageDigits import montageDigits
from linearTrain import linearTrain
from linearPredict import linearPredict

data = utils.loadmat('data.mat')

#  convert the training data to float
x = data['train']['x'].astype(np.float)

K = 100
patchSize = 9

# construct the dictionary
C = constructDictionary(x, K, patchSize)

# visualize the dictionary
_ = montageDigits(C)

# encode all images in training set
x_train = np.zeros((K, x.shape[2]))
for i in range(x.shape[2]):
    x_train[:, i] = encodeImage(x[:,:,i], C)
    
# train a linear model
model = linearTrain(x_train, data['train']['y'])

# encode all images in test set
v = data['test']['x'].astype(np.float)
x_test = np.zeros((K, v.shape[2]))
for i in range(v.shape[2]):
    x_test[:, i] = encodeImage(v[:,:,i], C)

# make the prediction
y_pred = linearPredict(model, x_test)

# evaluate the model
acc = np.sum(y_pred.astype(np.uint8) == data['test']['y']).astype(np.float) /\
        x_test.shape[1]
print('Accuracy on test set: %.3f\n'%acc)

