function mosim = mosaicImage(im)
% MOSAICIMAGE computes the mosaic of an image.
%   MOSIM = MOSAICIMAGE(IM) computes the response of the image under a
%   Bayer filter. Given an image IM = NxMx3, the output is a NxM image
%   where the R,G,B channels are sampled according to RGRG on the top left.
%
% This code is part of:
%
%   CMPSCI 370: Computer Vision, Fall 2014
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 1: Color images

[imageHeight, imageWidth, numChanels] = size(im);
assert(numChanels == 3); % Check that it is a color image
mosim = im;