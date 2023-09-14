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
[m,n]=size(I);
P=2*m;
Q=2*n;
% padding
Ip=padarray(I,[P Q],'post');
Np=padarray(N,[P Q],'post');

G=fftshift(fft2(Np));
F=fftshift(fft2(Ip));
H=I;
H=G./F;
D=Ip;
R=100;
for u=1:size(Np,2)
    for v=1:size(Np,1)
        du = u - size(Np,2)/2;
        dv = v - size(Np,1)/2;
        if du^2 + dv^2 <= R^2;
        D(u,v) = G(u,v)./H(u,v);
        end
    end
end

frestored=real(ifft2(ifftshift(D)));
imshowpair(N(1:m,1:n),frestored(1:m,1:n),'montag');