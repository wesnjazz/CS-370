import numpy as np
from skimage.color import rgb2gray
#from scipy.ndimage import convolve
from scipy.ndimage.filters import convolve
from nms import nms

from utils import gaussian

def detectCorners(I, is_simple, w, th):
    I = I.astype(float)
    if I.ndim > 2:
        I = rgb2gray(I)

    if is_simple:
        corner_score = simple_score(I, w)
    else:
        corner_score = harris_score(I, w)

    corner_score[corner_score < th] = 0

    cx, cy, cs = nms(corner_score)
    c = np.array([cx, cy, cs])
    isvalid = np.logical_and(
            np.logical_and(cx >= 0, cx < I.shape[1]),
            np.logical_and(cy >= 0, cy < I.shape[0]))
    return c[:, isvalid]


def simple_score(I, w):
    gs = gaussian(6*w+1, w)
    f = []

    f.append(np.array([[1, 0, 0], [0, -1, 0], [0, 0, 0]]))
    f.append(np.array([[0, 1, 0], [0, -1, 0], [0, 0, 0]]))
    f.append(np.array([[0, 0, 1], [0, -1, 0], [0, 0, 0]]))
    f.append(np.array([[0, 0, 0], [1, -1, 0], [0, 0, 0]]))
    f.append(np.array([[0, 0, 0], [0, -1, 1], [0, 0, 0]]))
    f.append(np.array([[0, 0, 0], [0, -1, 0], [1, 0, 0]]))
    f.append(np.array([[0, 0, 0], [0, -1, 0], [0, 1, 0]]))
    f.append(np.array([[0, 0, 0], [0, -1, 0], [0, 0, 1]]))

    corner_score = np.zeros_like(I)
    for i in xrange(8):
        diff = convolve(I, f[i], mode='nearest')
        diff_sum = convolve(diff**2, gs, mode='nearest')
        corner_score += diff_sum
    return corner_score


def harris_score(I, w):
    gx = np.array([[-1, 0, 1], [-1, 0, 1], [-1, 0, 1]])
    gy = gx.T

    imgx = convolve(I, gx, mode='nearest')
    imgy = convolve(I, gy, mode='nearest')

    gs = gaussian(6*w+1, w)
    
    imgx2 = convolve(imgx**2, gs, mode='nearest')
    imgy2 = convolve(imgy**2, gs, mode='nearest')
    imgxgy = convolve(imgx*imgy, gs, mode='nearest')
    corner_score = (imgx2 * imgy2 - imgxgy**2) - 0.04*(imgx2 + imgy2)**2

    return corner_score
