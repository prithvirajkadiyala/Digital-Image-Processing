clc;
clear all;
close all;

girl2=fopen('girl2.bin','r');
g=fread(girl2,[256,256],'uchar');
g=g';
figure(1);
colormap(gray(256));
image(g);
title('Original girl2 Image ');
axis off;
axis ('image');
print (figure(1),'2aa','-dpng');%writing out image for LaTeX purpose

girl2Noise32Hi=fopen('girl2Noise32Hi.bin','r');
gnh=fread(girl2Noise32Hi,[256,256],'uchar');
gnh=gnh';
figure(2);
colormap(gray(256));
image(gnh);
title('Original girl2Noise32Hi Image ');
axis off;
axis ('image');
print (figure(2),'2ab','-dpng');%writing out image for LaTeX purpose

girl2Noise32=fopen('girl2Noise32.bin','r');
gn=fread(girl2Noise32,[256,256],'uchar');
gn=gn';
figure(3);
colormap(gray(256));
image(gn);
title('Original girl2Noise32 Image ');
axis off;
axis ('image');
print (figure(3),'2ac','-dpng');%writing out image for LaTeX purpose

M=256;
N=256;
sum2=0;

for m=1:256
    sum1=0;
    for n=1:256
        NM=(g(m,n)-gnh(m,n))^2;
        sum1=sum1+NM;
    end
    sum2=sum2+sum1;
end
MSE1=sum2/(M*N);
display(MSE1);

M=256;
N=256;
sum2=0;
for m=1:256
    sum1=0;
    for n=1:256
        NM=(g(m,n)-gn(m,n))^2;
        sum1=sum1+NM;
    end
    sum2=sum2+sum1;
end

MSE2=sum2/(M*N);
display(MSE2);