clc
clear
close all
M=imread('Mammo.bmp');
if size(M,3)>1
    M=rgb2gray(M);
end
M=im2double(M);

J = adapthisteq(M,'clipLimit',0.02,'NumTiles',[16 16],'Distribution','rayleigh','alpha',4);
h = fspecial('laplacian');
H=imfilter(J,h);
M1=M-H;
B= ordfilt2(M1,5,ones(5,5),'symmetric');  
B=histeq(B);
B=B.*J;
imshowpair(M,B,'montag');
