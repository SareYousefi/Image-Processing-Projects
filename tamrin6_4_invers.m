clc
clear
close all
%% Invers  Filter
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
D0=120;
u = 0:(P-1);
v = 0:(Q-1);
idx = find(u > P/2);
u(idx) = u(idx) - P;
idy = find(v > Q/2);
v(idy) = v(idy) - Q;
[V, U] = meshgrid(v, u);
D = sqrt(U.^2 + V.^2);
H = 1-exp((-D.^2)./2.*D0);
G=fftshift(fft2(Np));
F=G;
R=120;
for u=1:size(G,2)
    for v=1:size(G,1)
        du = u - size(G,2)/2;
        dv = v - size(G,1)/2;
        if du^2 + dv^2 <= R^2
        F(u,v) = G(u,v)./H(u,v);
%         else
%             F(u,v)=G(u,v);
        end
    end
end
% figure,imshow(log(abs(F)),[]);
fRestored = real(ifft2(ifftshift(F)));
figure,imshowpair(N,fRestored(1:m,1:n),'montag');
title('Noisy Image, Restored Image')