clc
clear
close all
%-----Determine color image or gray image----
J= imread('peppers.png');
figure('Name','color image'); imshow(J)
if size(J,3)>1
    display('Color image')
else
    display('Gray image')
end
%double
Jb=im2double(J);
%
g=rgb2gray(J);
figure('Name','gray scale image');
imshow(g)
%----Fourier Transform---
F =fftshift(fft2(J));
F = log(abs(F)+1); % Use log, for perceptual scaling, and +1 since log(0) is undefined
F = mat2gray(F); % Use mat2gray to scale the image between 0 and 1
figure('Name','Fourier spectrum');
imshow(F); % Display the result
%-----Histogram of orginal image---
figure('Name','Histogram of orginal image');
imhist(J,256);
%------Histogram Equalization----
[I,T] = histeq(J);
figure('Name','Histogram Equalization');
subplot(2,1,1)
imshow(I)
subplot(2,1,2)
imhist(I,64);
%%-----Local Histograming process-------
%%
Ieq = zeros(size(g,1),size(g,2));
num_neighbors=9;
n= floor(num_neighbors/2);
for x=1+n:size(g,1)-n
    for y=1+n:size(g,2)-n
        if x-n<=1 %for rows
            from_row=1;
            to_row=x+n;
        else
            from_row=abs(x-n);
            if x+n> size(g,1)
                to_row=size(g,1);
            else
                to_row=x+n;
            end
        end
        
        if y-n<=1 %for columns
            from_column=1;
            to_column=y+n;
        else
            from_column=abs(y-n);
            if x+n> size(g,2)
                to_column=size(g,2);
            else
                to_column=y+n;
            end
        end
        neighbors = g(from_row:to_row,from_column:to_column);
        counts=imhist(neighbors,256);
%         counts = histeq(neighbors, 256);
        cdf = cumsum(counts);
        cdf= floor(cdf);
        cdf = cdf ./ cdf(end); % Normalize.
        % Get the original value of the central pixel that we need to replace.
        centerGrayLevel = g(x,y);
    % Now see what it gets mapped to.
    index = ceil(centerGrayLevel);
    newPixelValue = cdf(index);
        Ieq(x,y) = newPixelValue;
        
    end
end
figure ('Name','local histogram')
imshowpair(g,Ieq,'montag');

