clc
clear
close all
I=imread('white-blood-cell.png');
I=im2bw(I);
I=im2double(I);
I = imcomplement(I);
% figure,imshowpair(I,J,'montage');
%%  Structuring Element
SE = strel('disk',2,0);
figure,imshow(SE.Neighborhood);
%% Erosion & Dilation
packopt=1;
erodedI = imerode(I,SE,packopt);
figure,imshowpair(I,erodedI,'montag');
title('Orginal Binary Image    Eroded Image')
dilatedI = imdilate(I,SE,packopt);
figure,imshowpair(I,dilatedI,'montag');
title('Orginal Binary Image    Dilated Image')

% nhood=[1 1 1;1 1 1;1 1 1];
% erodedI1 = imerode(I,nhood,packopt);
% figure,imshowpair(I,erodedI1,'montag');
% title('Orginal Binary Image    Eroded Image*')
% 
% dilatedI1 = imdilate(I,nhood,packopt);
% figure,imshowpair(I,dilatedI1,'montag');
% title('Orginal Binary Image    Dilated Image*')
%% Opening & Closing
closingI = imclose(I,SE);
% closingI = bwmorph(I,'close');
figure,imshowpair(I,closingI,'montag');
title('Orginal Binary Image    Closed Image')

openingI = imopen(I,SE);
% openingI = bwmorph(I,'open');
figure,imshowpair(I,openingI,'montag');
title('Orginal Binary Image    Opened Image')


