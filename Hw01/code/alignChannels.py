# This code is part of:
#
#   CMPSCI 370: Computer Vision, Spring 2018
#   University of Massachusetts, Amherst
#   Instructor: Subhransu Maji
#
#   Homework 1 

import numpy as np

def alignChannels(img, max_shift):

    # Check if image is big enough to do cropping for the better alignment
    if img.shape[0] > (max_shift[0]*20) and img.shape[1] > (max_shift[1]*20):
        # print("Image is big enough to do Cropping!!! for better alignments")
        img_aligned = img[max_shift[0]*2:-max_shift[0]*2, max_shift[1]*2:-max_shift[1]*2]
    else:
        # image is small, so no cropping.
        img_aligned = img[:,:,:]

    # Get a reference channel to compare when align
    red = img_aligned[:,:,0]
    # convert it to a 1D vector
    r_flat = red.flatten()

    # storage to record shifting numbers
    pred_shift = np.array([[0, 0], [0, 0]])
    
    # Compare: RED -> BLUE
    # search for all possible combination of shifts for one color channel
    max_dot_b = 0
    for i in range(-max_shift[0], max_shift[0]+1):
    	for j in range(-max_shift[1], max_shift[1]+1):
            # get separate 2D matrix for a color
            blue = np.roll(img_aligned[:,:,1], [i, j], axis=[0,1])

            # convert the obtained 2D matrix into a flatten matrix so it becomes a 1D vector
            b_flat = blue.flatten()

            # get a dot product(inner product) between two color channel vectors to check similarity
            new_dot = np.dot(r_flat, b_flat)

            # if found a better shift(smaller scalar value from dot product)
            if new_dot > max_dot_b:
            	max_dot_b = new_dot
            	pred_shift[0] = np.array([i, j])

    # Compare: RED -> GREEN
    # search for all possible combination of shifts for one color channel
    max_dot_g = 0
    for i in range(-max_shift[0], max_shift[0]+1):
    	for j in range(-max_shift[1], max_shift[1]+1):
    		# get separate 2D matrix for a color
    		green = np.roll(img_aligned[:,:,2], [i, j], axis=[0,1])

    		# convert the obtained 2D matrix into a flatten matrix so it becomes a 1D vector
    		g_flat = green.flatten()
    		
    		# get a dot product(inner product) between two color channel vectors to check similarity
    		new_dot = np.dot(r_flat, g_flat)

    		# if found a better shift(smaller scalar value from dot product)
    		if new_dot > max_dot_g:
    			max_dot_g = new_dot
    			pred_shift[1] = np.array([i, j])

    # align the image with predicted shifting numbers
    img_aligned[:,:,1] = np.roll(img_aligned[:,:,1], [pred_shift[0][0], pred_shift[0][1]], axis=[0,1])
    img_aligned[:,:,2] = np.roll(img_aligned[:,:,2], [pred_shift[1][0], pred_shift[1][1]], axis=[0,1])

    return (img_aligned, pred_shift)

