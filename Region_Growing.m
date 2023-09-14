clc 
clear all
close all
I=im2double(rgb2gray(imread('MRI2.jpeg')));
figure,imshow(I);
% [x, y]=ginput(1); %pick one pixel of the region to be segmented
x=400;
y=163;
% Tpumor=(x y);
[row col]=size(I);
m=impixel(I,x,y);
neighbors=[-1 0;1 0;0 -1;0 1];
for j=1:4
    x_new=x+neighbors(j,1);
    y_new=y+neighbors(j,2);
 if I(x,y)>=m   
    T_segment=impixel(I,x_new,y_new);
 end
end
figure,imshow(T_segment);
total_area= bwarea(T_segment)

