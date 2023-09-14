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
if size(I,3)>1
    N=rgb2gray(N);
end
N=im2double(N);

%%
% padding
[m,n]=size(I);
P=2*m;
Q=2*n;
% padding
Ip=padarray(I,[P Q],'post');
Bp=padarray(B,[P Q],'post');
Np=padarray(N,[P Q],'post');

        
% part1:
In=fftshift(fft2(Ip));
Out=fftshift(fft2(Bp));
H=In;
H=Out./In;
figure,imshow(log(abs(H)),[]);
h=abs(ifftshift(ifft2(H,31,31)));
figure,imshow(h,[]);
title('h,Blurred Image')

%%
% part2:
In2=fftshift(fft2(Ip));
Out2=fftshift(fft2(Np));
H2=In2;
H2=Out2./In2;
figure,imshow(log(abs(H2)),[]);
h2=abs(ifftshift(ifft2(H2,31,31)));
figure,imshow(h2,[]);
title('h,Noisy Blurred Image')
%%