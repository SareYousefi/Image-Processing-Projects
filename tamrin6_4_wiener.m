clc
clear
close all
%% Wiener Filter
N=imread('NoisyBluredPhantom.jpg');
if size(N,3)>1
    N=rgb2gray(N);
end
N=im2double(N);
% padding
[m,n]=size(N);
P=2*m;
Q=2*n;
Np=padarray(N,[P Q],'post');
G=fftshift(fft2(Np));
PG=(abs(fftshift(fft2(Np)))).^2;
PF=PG;
PN=(0.5)*ones(size(PF));

w=zeros(size(G));
for i=1:100
    w=PF./PF+PN;
    F=w.*G;
    PF=abs(F);
end
F=G.*w;
frestored=abs((ifft2(F)));
figure
imshowpair(N,frestored(1:m,1:n),'montag');