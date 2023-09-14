clc
clear
close all
I=imread('Phantom.jpg');
if size(I,3)>1
    I=rgb2gray(I);
end
I=im2double(I);

N=imread('NoisyBluredPhantom.jpg');
if size(N,3)>1
    N=rgb2gray(N);
end
N=im2double(N);
% padding
[m,n]=size(I);
P=2*m;
Q=2*n;
Ip=padarray(I,[P Q],'post');
Np=padarray(N,[P Q],'post');

G=fftshift(fft2(Np));
F=fftshift(fft2(Ip));
PFF=(abs(F)).^2;
PNN=(0.5).*ones(size(PFF));
H=I;
H=G./F;
h=abs(ifftshift(ifft2(H)));
w=(1./H).*((H.^2)./((H.^2)+(PNN./PFF)));
B=G.*w;
frestored=abs((ifft2(B)));
figure
imshowpair(N(1:m,1:n),frestored(1:m,1:n),'montag');