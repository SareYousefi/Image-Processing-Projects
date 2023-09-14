clc
clear
close all
%% Wiener Filter
N=imread('NoisyBluredPhantom.jpg');
if size(N,3)>1
    N=rgb2gray(N);
end
N=im2double(N);
%
r=3;
c=3;
% padding
nr= floor(r/2);
nc= floor(c/2);
J1= padarray(N,[nr nc]);

mu_local=N;
mu_local(:,:)=0;
v_local=N;
v_local(:,:)=0;
[rows,cols]= size(J1);
for i=nr+1:rows-nr
    for j=nc+1:cols-nc
        temp= J1(i-nr:i+nr,j-nc:j+nc);
        mu_local(i-nr,j-nc)=mean(temp(:));
        v_local(i-nr,j-nc)= var(temp(:));  
    end
end
% noise variance
v_noise= mean(v_local(:));
%wiener filter
J2= N;
J2(:,:)= 0;
[rows,cols]= size(N);
for i=1:rows
    for j=1:cols
        a= N(i,j);
        mu= mu_local(i,j);
        s2= v_local(i,j);
        b= mu + (max(s2 - v_noise,0)/max(s2,v_noise))* (a-mu);
        J2(i,j)= b;
    end
end
figure
imshowpair(N,J2,'montag');
title('Noisy Blurred Image,Weiner Filter')

