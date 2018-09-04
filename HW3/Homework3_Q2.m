clc;
close all;

fidlady = fopen('lady.256','r');
[lady,junk] = fread(fidlady,[256,256],'uchar');
lady = lady' ; % you must trasnpose the image
figure(1);colormap(gray(256));
image(lady);
title('Original lady Image');
axis image;
axis off;
print (figure(1),'Original_Lady','-dpng');%writing out image for LaTeX purpose

R=lady;
h=sum(hist(R,0:255)');
figure(2);
bar(h);
title('Histogram for original image');
print (figure(2),'Original_Hist','-dpng');%writing out image for LaTeX purpose

A=55;
B=144;
J=zeros(256,256);
for m=1:256
    for n=1:256
        J(m,n)=(255/89)*(R(m,n)-55);
    end
end
figure(3);colormap(gray(256));
image(J);
title('Full scale contrast stretch image');
axis image;
axis off;
print (figure(3),'Contrast_Image','-dpng');%writing out image for LaTeX purpose

h1=sum(hist(J,0:255)');
figure(4);
bar(h1);
title('Histogram after full scale contrast stretch');
print (figure(4),'Contrasted_Hist','-dpng');%writing out image for LaTeX purpose