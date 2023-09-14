clc
clear
close all
I=imread('white-blood-cell.png');
I=rgb2gray(I);
I=im2double(I);
%% preprocessing
h = fspecial('log');
H=imfilter(I,h);
H=H.*I;
figure, imshow(H);
title('filtered Image using LOG filter')
%% Segmentation
T = graythresh(H);
BW = imbinarize(H,T);
figure,imshow(BW);
title('Thresholding,Otsu''s method')
%% Morphology
SE1 =[1 1 ];
packopt=1;
erodeI = imerode(BW,SE1,packopt);
BW2=erodeI.*BW;
I2=imdilate(BW2,SE1);
%% Counts cell's
figure, imshow(I2)
title('Out put of morphology operation')
figure, imshow(I2)
title('circles')
[centers,radii] = imfindcircles(BW2,[5 15],'ObjectPolarity','bright', ...
    'Sensitivity',0.92,'Method','twostage','EdgeThreshold',0.15);
h = viscircles(centers,radii,'Color','r');
