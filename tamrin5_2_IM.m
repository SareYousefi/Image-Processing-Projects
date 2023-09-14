clc
clear
close all
im=imread('IM.png');
if size(im,3)>1
    im=rgb2gray(im);
end
im=im2double(im);
h = fspecial('disk');
H=imfilter(im,h);

J = adapthisteq(H,'clipLimit',0.02,'Distribution','rayleigh','Alpha',7);
% eroding dark  regions adjacent to bright areas.
B = ordfilt2(J,9,ones(3,3),'symmetric');
imshowpair(B,J,'montag')

