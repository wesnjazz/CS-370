import numpy as np
from skimage.color import rgb2gray
from scipy.ndimage.filters import convolve
from nms import nms

from utils import gaussian

# This code is part of:
#
#   CMPSCI 370: Computer Vision, Spring 2016
#   University of Massachusetts, Amherst
#   Instructor: Subhransu Maji
#
#   Homework 3


def detectCorners(I, is_simple, w, th):
#Conver to float
    I = I.astype(float)

    #Convert color to grayscale
    if I.ndim > 2:
        I = rgb2gray(I)

    # Step 1: compute corner score
    if is_simple:
        corner_score = simple_score(I, w)
    else:
        corner_score = harris_score(I, w)

    # Step 2: Threshold corner score and find peaks
    corner_score[corner_score < th] = 0

    cx, cy, cs = nms(corner_score)
    return cx, cy, cs


#--------------------------------------------------------------------------
#                                    Simple score function (Implement this)
#--------------------------------------------------------------------------
def simple_score(I, w):
    corner_score = 0.051*np.random.random(I.shape)
    return corner_score


#--------------------------------------------------------------------------
#                                    Harris score function (Implement this)
#--------------------------------------------------------------------------
def harris_score(I, w):
    corner_score = 0.000102*np.random.random(I.shape)
    return corner_score
