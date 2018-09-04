clc;
close all;

fidjohnny = fopen('johnny.bin','r');
[johnny,junk] = fread(fidjohnny,[256,256],'uchar');
johnny = johnny' ; % you must trasnpose the image
figure(1);colormap(gray(256));
image(johnny);
title('Original johnny Image');
axis image;
axis off;
print (figure(1),'Original_Johny_Image','-dpng');%writing out image for LaTeX purpose
print -dtiff M_johnny.tif; % write figure as tif

fidOut = fopen('Outfile.bin','w+');
johnnyOut = johnny';
fwrite(fidOut,johnnyOut,'uchar'); % write raw image data
fclose(fidjohnny);fclose(fidOut);
R=johnny;
h=sum(hist(R,0:255)');
figure(2);
bar(h);
title('Histogram');
print (figure(2),'Johny_Hist','-dpng');%writing out image for LaTeX purpose

p=zeros(1,256);
for n=1:256
    p(1,n)=h(1,n)/(256*256);
end
P=zeros(1,256);
for r=1:256
    P(r)=sum(p(1,1:r));
end
figure(3);
bar(P);
title('cumulative histogram');
print (figure(3),'Cumulative_Hist','-dpng');%writing out image for LaTeX purpose

J=zeros(256,256);
for i=1:256
    for j=1:256
        J(i,j)=P(1,R(i,j)+1);
    end
end
figure(4);
imshow(J);
title('Equalized Image');
axis image;
axis off;
print (figure(4),'Equalized_Image','-dpng');%writing out image for LaTeX purpose

h3=sum(hist(J,0:255));
figure(5);
bar(h3);
title('Equalized Image Histogram');
print (figure(5),'Equalized_Hist','-dpng');%writing out image for LaTeX purpose