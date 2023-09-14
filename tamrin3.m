clc
clear
close all
grayImage = rgb2gray(imread('parkavenue.jpg'));
subplot(1,2,1);
imshow(grayImage);
title('Orginal gray level image')
% double
grayImage=im2double(grayImage);
[I,T] = histeq(grayImage);
subplot(1,2,2)
imshow(I)
title('Hisogram Equalization of image')
%%
% grayImage= imhist(grayImage,256);
% I=imhist(I,256);
% max intensity
max_intensity_Orginal=max(grayImage(:))
max_intensity_H=max(I(:))

% min intensity
min_intensity_Orginal=min(grayImage(:))
min_intensity_H=min(I(:))

% Dynamic range
D_Orginal=max_intensity_Orginal-min_intensity_Orginal
D_H=max_intensity_H-min_intensity_H

% mean
mean_Orginal= mean(grayImage(:))
mean_H=mean(I(:))

% variance
var_Orginal= var(grayImage(:))
var_H=var(I(:))

% mean squar
mean2_Orginal= mean((grayImage(:)).^2)
mean2_H=mean((I(:)).^2)

% entropy
e_O = entropy(grayImage)
e_H = entropy(I)
% Kortosis
k_Orginal = kurtosis(grayImage(:))
k_H = kurtosis(I(:))

