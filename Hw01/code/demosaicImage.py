# This code is part of:
#
#   CMPSCI 370: Computer Vision, Spring 2018
#   University of Massachusetts, Amherst
#   Instructor: Subhransu Maji
#
#   Homework 1 

import numpy as np

def demosaicImage(image, method):
    ''' Demosaics image.

    Args:
        img: np.array of size NxM.
        method: demosaicing method (baseline or nn).

    Returns:
        Color image of size NxMx3 computed using method.
    '''

    if method.lower() == "baseline":
        return demosaicBaseline(image.copy())
    elif method.lower() == 'nn':
        return demosaicNN(image.copy()) # Implement this
    else:
        raise ValueError("method {} unkown.".format(method))


def demosaicBaseline(img):
    '''Baseline demosaicing.
    
    Replaces missing values with the mean of each color channel.
    
    Args:
        img: np.array of size NxM.

    Returns:
        Color image of sieze NxMx3 demosaiced using the baseline 
        algorithm.
    '''
    mos_img = np.tile(img[:, :, np.newaxis], [1, 1, 3])
    image_height, image_width = img.shape

    red_values = img[0:image_height:2, 0:image_width:2]
    mean_value = red_values.mean()
    mos_img[:, :, 0] = mean_value
    mos_img[0:image_height:2, 0:image_width:2, 0] = img[0:image_height:2, 0:image_width:2]

    blue_values = img[1:image_height:2, 1:image_width:2]
    mean_value = blue_values.mean()
    mos_img[:, :, 2] = mean_value
    mos_img[1:image_height:2, 1:image_width:2, 2] = img[1:image_height:2, 1:image_width:2]

    mask = np.ones((image_height, image_width))
    mask[0:image_height:2, 0:image_width:2] = -1
    mask[1:image_height:2, 1:image_width:2] = -1
    green_values = mos_img[mask > 0]
    mean_value = green_values.mean()

    green_channel = img
    green_channel[mask < 0] = mean_value
    mos_img[:, :, 1] = green_channel

    return mos_img


def demosaicNN(img):
    '''Nearest neighbor demosaicing.
    
    Args:
        img: np.array of size NxM.

    Returns:
        Color image of size NxMx3 demosaiced using the nearest neighbor 
        algorithm.
    '''

    # Check if image has odd height or width
    image_height, image_width = img.shape
    is_odd_height = 0 if image_height % 2 == 0 else 1
    is_odd_width = 0 if image_width % 2 == 0 else 1

    # new height and width
    nH = image_height - 1 if is_odd_height == 1 else image_height
    nW = image_width - 1 if is_odd_width == 1 else image_width

    # empty array for return
    result = np.empty((image_height, image_width, 3))


    ### RED ###

    # 1. retrieve original R value
    # Position: X O
    #           O O
    result[:nH:2, :nW:2, 0] = img[:nH:2, :nW:2]

    # 2. Filling in missing values
    result[:nH:2, 1:nW:2, 0] = img[:nH:2, :nW:2] # upper right - copy from upper left
    result[1:nH:2, 1:nW:2, 0] = img[:nH:2, :nW:2] # lower right - copy from upper left
    result[1:nH:2, :nW:2, 0] = img[:nH:2, :nW:2] # lower left - copy from upper left
    # 3. Handle Egde Cases
    if is_odd_height:
        result[-1, ::, 0] = result[-2, ::, 0]
    if is_odd_width:
        result[::, -1, 0] = result[::, -2, 0]


    ### BLUE ###
    # 1. retrieve original B value
    # Position: O O
    #           O X
    result[1:nH:2, 1:nW:2, 1] = img[1:nH:2, 1:nW:2]

    # 2. filling in missing values
    result[1:nH:2, 0:nW:2, 1] = img[1:nH:2, 1:nW:2] # lower left - copy from lower right
    result[:nH:2, :nW:2, 1] = img[1:nH:2, 1:nW:2] # upper left - copy from lower right
    result[:nH:2, 1:nW:2, 1] = img[1:nH:2, 1:nW:2] # upper right - copy from lower right
    # 3. Handle Edge Cases
    if is_odd_height:
        result[-1, ::, 1] = result[-2, ::, 1]
    if is_odd_width:
        result[::, -1, 1] = result[::, -2, 1]


    ### GREEN ###
    # 1. retrieve original B value
    # Position: O O
    #           X O
    result[1:nH:2, 0:nW:2, 2] = img[1:nH:2, 0:nW:2]
    # Position: O X
    #           O O
    result[0:nH:2, 1:nW:2, 2] = img[0:nH:2, 1:nW:2]
    # 2. filling in missing values
    result[:nH:2, :nW:2, 2] = img[:nH:2, 1:nW:2] # upper left - copy from upper right
    result[1:nH:2, 1:nW:2, 2] = img[1:nH:2, :nW:2] # lower right - copy from lower left
    # 3. Handle edge cases
    if is_odd_height:
        result[-1, ::, 2] = result[-2, ::, 2]
    if is_odd_width:
        result[::, -1, 2] = result[::, -2, 2]

    return result
