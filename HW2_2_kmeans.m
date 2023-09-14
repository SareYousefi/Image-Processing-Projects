clc
clear
close all
I=imread('MRI2.jpeg');
I=rgb2gray(I);
I=im2double(I);
subplot(1,4,1),imshow(I);
title('Orginal Image');
%
[m,n]=size(I);
ind=[0.1553;0.4959;0.0114];
C=kmeans(I(:),3,'Start',ind);
I2=reshape(C,[m,n]);
subplot(1,4,2),imshow(I2,[]);
title('kmeans');
[counts centers]=hist(I2,3);
U=unique(centers);
T1=U(2)-0.5;
T2=U(2)+0.5;
for i=1:m
    for j=1:n
        if I2(i,j)<T1 | I2(i,j)>T2
            I2(i,j)=0;
        end
    end
end
subplot(1,4,3),imshow(I2,[]);
title('Threshold Image');
%
nhood=ones(15,15);
openI1 = imopen(I2,nhood);
subplot(1,4,4),imshow(openI1,[]);
title('Tumor Image');
%area
% w=find(openI1==2);
% area= length(w)
figure,imshowpair(openI1,I,'falsecolor');
Area=bwarea(openI1)
