clc;
close all;
clear all;
fidcamera99 = fopen('camera99.bin','r');
[camera99,junk] = fread(fidcamera99,[256,256],'uchar');
camera99 = camera99' ;% for trasnpose of the image
figure(1);colormap(gray(256));
image(camera99);
title('Original camera99 Image');
axis off;
axis ('image');
print (figure(1),'1aa','-dpng');%writing out image for LaTeX purpose
I=camera99;

%Selecting the size for window
size=256;
windowsize=3;

%windowsize2=floor(windowsize/2);
Window=zeros(windowsize);
Median=zeros(size);
Erode=zeros(size);
Dilate=zeros(size);
Open=zeros(size);
Close=zeros(size);

%Performing Erode, Medain and Dilate
for i=2:255
    for j=2:255
        Window=I(i-1:i+1,j-1:j+1);
        Median(i,j)=median(median(Window));
        Erode(i,j)=min(min(Window));
        Dilate(i,j)=max(max(Window));
    end
end

%Performing Open and Close
for i=3:254
    for j=3:254
        Window=Erode(i-1:i+1,j-1:j+1);
        Open(i,j)=max(max(Window));
        Window=Dilate(i-1:i+1,j-1:j+1);
        Close(i,j)=min(min(Window));
    end
end

%Displaying the Results
figure(2);
colormap(gray(256));
image(Median);
title('Median filtered Camera 99 Image');
axis off;
axis ('image');
print (figure(2),'1ab','-dpng');%writing out image for LaTeX purpose

figure(3);
colormap(gray(256));
image(Open);
title('Open Camera 99 Image');
axis off;
axis ('image');
print (figure(3),'1ac','-dpng');%writing out image for LaTeX purpose

figure(4);
colormap(gray(256));
image(Close);
title('Close Camera 99 Image');
axis off;
axis ('image');
print (figure(4),'1ad','-dpng');%writing out image for LaTeX purpose