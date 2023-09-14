clc
clear
close all
I=imread('MRI2.jpeg');
I=rgb2gray(I);
I=im2double(I);
subplot(3,2,1), imshow(I);
title('a:Orginal Image');
%
[Gmag,~] = imgradient(I);
T = graythresh(Gmag);
BW_g = imbinarize(Gmag,T);
subplot(3,2,2),imshow(BW_g);
title('b:Segmentation with Otsu''s Method on Gradient of a');
% 
T1 = graythresh(I);
BW1 = imbinarize(I,T1);
subplot(3,2,3),imshow(BW1);
title('c:Segmentation with Otsu''s Method on a');

nhood1=strel('disk',7);
openI1 = imopen(BW1,nhood1);
nhood2=ones(19,19);
openI2 = imopen(openI1,nhood2);
subplot(3,2,4),imshow(openI2,[]);
title('d:opening operation on c');
Gi=imcomplement(BW_g);
subplot(3,2,5),imshow(Gi,[]);
title('e:complement of b');
Tomur=Gi.*openI2;
subplot(3,2,6),imshow(Tomur,[]);
title('Tumor Image (product of d and e)');
% area
% w=find(Tomur==1);
% area= length(w)
figure,imshowpair(Tomur,I,'falsecolor');
Area=bwarea(Tomur)
% 