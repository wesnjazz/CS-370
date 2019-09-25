# This code is part of:
#
#   CMPSCI 370: Computer Vision, Spring 2018
#   University of Massachusetts, Amherst
#   Instructor: Subhransu Maji
#
#   Homework 1

import numpy as np

def mosaicImage(img):
    ''' Computes the mosaic of an image.

    mosaicImage computes the response of the image under a Bayer filter.

    Args:
        img: NxMx3 numpy array (image).

    Returns:
        NxM image where R, G, B channels are sampled according to RGRG in the
        top left.
    '''

    image_height, image_width, num_channels = img.shape
    assert(num_channels == 3) #Checks if it is a color image

    # make an empty matrix
    result = np.empty((image_height, image_width))

    # take red channel
    result[::2, ::2] = img[::2, ::2, 0]

    # take blue channel
    result[1::2, 1::2] = img[1::2, 1::2, 1]

    # take green channel
    result[1::2, 0::2] = img[1::2, 0::2, 2]
    result[0::2, 1::2] = img[0::2, 1::2, 2]

    return result
