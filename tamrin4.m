clc
clear
close all
I=(150)*ones(128,128);
H=hist(I);

% % Gussian nois
J = imnoise(I,'gaussian',0.02);
subplot(2,4,1),imshow(J,[]);
title('Gussian Noisy');
subplot(2,4,5),hist(J./max(J(:)),10);

% % uniform
U_noisy_image = conv2(H,rand(size(I)));
subplot(2,4,2),imshow(U_noisy_image,[]);
title('uniform Noisy');
subplot(2,4,6),hist(U_noisy_image./max(U_noisy_image(:)),10);

% %exponential
E_noisy_image = conv2(H,9.*exp((-9).*rand(size(I))));
subplot(2,4,3),imshow(E_noisy_image,[]);
title('Exponential Noisy');
subplot(2,4,7),hist(E_noisy_image./max(E_noisy_image(:)),10);

% %triangular
a=0; b=1; c=0.5; n=128;
X=zeros(n,1);
for i=1:n
    z=rand;
    if sqrt(z*(b-a)*(c-a))+a<c
        X(i)= sqrt(z*(b-a)*(c-a))+a;
    else
        X(i)=b-sqrt((1-z)*(b-a)*(b-c));
    end
end    
T_noisy_image= conv2(H,X);
subplot(2,4,4),imshow(T_noisy_image,[]);
title('Triangular Noisy');
subplot(2,4,8),hist(T_noisy_image./max(T_noisy_image(:)),10);
%
%% part2
[m,n]=size(I);
DCT1=dct2(J,[m,n]);
DCT2=dct2(U_noisy_image,[m,n]);
DCT3=dct2(E_noisy_image,[m,n]);
DCT4=dct2(T_noisy_image,[m,n]);
figure
subplot(5,1,2)
histogram(DCT1,20,'normalization','pdf');
grid on
title('Gussian Noisy');
subplot(5,1,3)
histogram(DCT2,20,'normalization','pdf');
grid on
title('Uniform Noisy');
subplot(5,1,4)
histogram(DCT3,20,'normalization','pdf');
grid on
title('Exponential Noisy');
subplot(5,1,5)
histogram(DCT4,20,'normalization','pdf');
grid on
title('Traingular Noisy');
% 
%% part 3:
im=im2double(rgb2gray(imread('MRI.jpg')));
figure
imshow(im,[]);
[m,n]=size(im);
DCT=dct2(im,[m,n]);
figure
histogram(DCT,20,'normalization','pdf');
grid on
title('Hist of DCT MRI image','fontsize',10)