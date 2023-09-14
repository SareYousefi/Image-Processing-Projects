clc
clear
close all
%% Histogram
M=imread('Mammo.bmp');
if size(M,3)>1
    M=rgb2gray(M);
end
M=im2double(M);
J = adapthisteq(M,'clipLimit',0.02,'Distribution','rayleigh','Alpha',1);
Je=histeq(M);
figure
imshowpair(J,Je,'montage')
title('Adaptiv histeq , hist eq')

im=imread('IM.png');
if size(im,3)>1
    im=rgb2gray(im);
end
im=im2double(im);
J1 = adapthisteq(im,'clipLimit',0.02,'Distribution','exponential');
J1e=histeq(im);
figure
imshowpair(J1,J1e,'montage')
title('Adaptiv histeq , hist eq')
%% Frequency Donain
% low pass
sigma=3;
G1=imgaussfilt(M,sigma);
figure
imshowpair(G1,M,'montage')
title('Low pass , orginal')

G2=imgaussfilt(im,sigma);
figure
imshowpair(G2,im,'montage')
title('Low pass , orginal')

% high pass
h = fspecial('disk');
H1=imfilter(M,h);
figure
imshowpair(H1,M,'montage')
title('disk , orginal')

h = fspecial('sobel');
H2=imfilter(im,h);
figure
imshowpair(H2,im,'montage')
title('sobel , orginal')

%% Saptial Domain
B1 = ordfilt2(M,5,ones(11,11),'symmetric');
figure
imshowpair(B1,M,'montage');
title('median filter , orginal')


B2 = ordfilt2(im,9,ones(11,11),'symmetric');
figure
imshowpair(B2,im,'montage');
title('max filter , orginal')
