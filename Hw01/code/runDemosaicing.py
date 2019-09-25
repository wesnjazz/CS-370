# This code is part of:
#
#   CMPSCI 370: Computer Vision, Spring 2018
#   University of Massachusetts, Amherst
#   Instructor: Subhransu Maji
#

import numpy as np
from utils import *
from mosaicImage import *
from demosaicImage import *

def runDemosaicing(imgpath, method, display, imgname):
    ''' Simulates mosaicing and demosaicing.

    Args:
        imgpath : str
            Path to an image.
        method : str
            'baseline' or 'nn'.
        display : bool
            True if one wishes to see demosaicing results and error.
            False otherwise.

    Returns:
        (error, output) : (float, np.array)
            Error and demosaiced image.

    '''

    #Load ground truth image
    gt = imread(imgpath)
    #Create a mosaiced image
    input_img = mosaicImage(gt.copy())
    #Compute a demosaiced image
    output = demosaicImage(input_img, method)
    #Sanity check.
    assert (output.shape == gt.shape)

    #Compute error.
    pixel_error = np.abs(gt - output)
    error = pixel_error.mean()

    #Visualize errors if display is set.
    if display:
        # if method == 'nn':
        #     plt.figure()
        #     plt.imshow(output)
        #     plt.savefig('Demosaic_' + imgname)

        plt.figure(1)
        plt.clf()

        # TEST
        # plt.subplot(141)
        # plt.title('Input image'); plt.imshow(gt); plt.axis('off')

        # plt.subplot(142) 
        # plt.title('Output'); plt.imshow(output); plt.axis('off')

        # plt.subplot(143) 
        # plt.title('Error'); plt.imshow(pixel_error); plt.axis('off')

        # plt.subplot(144)
        # plt.title('Mosaic image'); plt.imshow(input_img); plt.axis('off')

        plt.subplot(131)
        plt.title('Input image'); plt.imshow(gt); plt.axis('off')

        plt.subplot(132) 
        plt.title('Output'); plt.imshow(output); plt.axis('off')

        plt.subplot(133) 
        plt.title('Error'); plt.imshow(pixel_error); plt.axis('off')

        if method == 'nn':
            plt.savefig('Demosaic_'+ imgname)
        plt.show()
    
    return error, output
