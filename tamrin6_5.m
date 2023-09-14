clc
clear
close all

I=imread('Phantom.jpg');
if size(I,3)>1
    I=rgb2gray(I);
end
I=im2double(I);

B=imread('BluredPhantom.jpg');
if size(B,3)>1
    B=rgb2gray(B);
end
B=im2double(B);


N=imread('NoisyBluredPhantom.jpg');
if size(N,3)>1
    N=rgb2gray(N);
end
N=im2double(N);

%%
% part1:
In=fftshift(fft2(I));
Out=fftshift(fft2(B));
H=In;
H=Out./In;
h=abs(ifftshift(ifft2(H,31,31)));
%
INITPSF = ones(size(B));
[J1,~] = deconvblind(B,INITPSF);
figure, imshowpair(B,J1,'montag')
title('deconvblind')
J2 = deconvlucy(B,INITPSF,150); 
figure , imshowpair(B,J2,'montag')
title('deconvlucy')
J3 = deconvreg(B,INITPSF);
figure , imshowpair(B,J3,'montag')
title('deconvreg')
J4 = deconvwnr(B,INITPSF); 
figure , imshowpair(B,J4,'montag')
title('deconvwnr')

