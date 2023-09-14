clc
clear
close all
% "Adaptive Gaussian Notch Filter for Removing  
%Periodic Noise from Digital Images"
I = imread('tamrin2.png');
im=im2double(I);
[m,n]=size(im);
F_in=fftshift(fft2(im));
P=abs((F_in));
Th=0.55;
% rgn for avoiding DC cancealltion 
rgn=6;
F_out=F_in;
% wmax: maximum window size
wmax=10;
for i=10:m-9
    for j=10:n-9
       d=sqrt((i-(m/2))^2+(j-(n/2))^2);
        if (d>rgn) 
            % w1: inner window
            w1=1;
            cond=1;
            while(cond==1)
                % w2:outer window
                w2=w1+1;
                s1=0;
                s2=0;
                co1=0;
                co2=0;
                for k=-w2:w2
                    for l=-w2:w2
                        if (abs(k)<=w1)&&(abs(l)<=w1)
                            co1=co1+1;
                            s1=s1+P(i+k,j+l);
                        else
                            co2=co2+1;
                            s2=s2+P(i+k,j+l);
                        end                
                    end
                end
                if ((s2/co2)/(s1/co1))<Th
                    if w2>=wmax
                        cond=0;
                    else
                         w1=w1+1;            
                    end
                    for k=-w2:w2
                        for l=-w2:w2
                            h(w2+1+k,w2+1+l)=1-exp((-0.005)*(k^2+l^2));
                            F_out(i+k,j+l)=min(F_in(i+k,j+l)*h(w2+1+k,w2+1+l),F_out(i+k,j+l));
                        end
                    end
                    clear h;
                else
                    cond=0;
                end
            end
        end
    end
end
R_img=real(ifft2(ifftshift(F_out)));
R_img=rgb2gray(R_img);

% 

I2=zeros(size(R_img));
for r=1:size(R_img,1)
    for c=1:size(R_img,2)
        I2(r,c)=R_img(r,c).^(1.5);
    end
end
figure
imshowpair(im,I2,'montage')
title('Orginal image , Out put image')
