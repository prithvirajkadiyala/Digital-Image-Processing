clc;
close all;
clear all;

girl2=fopen('girl2.bin','r');
g=fread(girl2,[256,256],'uchar');
g=g';
figure(1);
colormap(gray(256));
image(g);
title('Original girl2 Image ');
axis off;
axis ('image');
print (figure(1),'2ba','-dpng');%writing out image for LaTeX purpose

%
girl2Noise32Hi=fopen('girl2Noise32Hi.bin','r');
gnh=fread(girl2Noise32Hi,[256,256],'uchar');
gnh=gnh';
figure(2);
colormap(gray(256));
image(gnh);
title('Original girl2Noise32Hi Image ');
axis off;
axis ('image');
print (figure(2),'2bb','-dpng');%writing out image for LaTeX purpose

%
girl2Noise32=fopen('girl2Noise32.bin','r');
gn=fread(girl2Noise32,[256,256],'uchar');
gn=gn';
figure(3);
colormap(gray(256));
image(gn);
title('Original girl2Noise32 Image ');
axis off;
axis ('image');
print (figure(3),'2bc','-dpng');%writing out image for LaTeX purpose

%Computing the MSE
P=256;
Q=256;
sum2=0;
for m=1:256
    sum1=0;
    for n=1:256
        QP=(g(m,n)-gnh(m,n))^2;
        sum1=sum1+QP;
    end
    sum2=sum2+sum1;
end
MSE1=sum2/(P*Q);
disp('MSE between girl2 and girl2Noise32Hi ');
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
disp('MSE between girl2 image and girl2Noise32 image ');
display(MSE2);

%Filter
U_cutoff = 64;
[U,V] = meshgrid(-128:127,-128:127);
HLtildeCenter = double(sqrt(U.^2 + V.^2) <= U_cutoff);
HLtilde = fftshift(HLtildeCenter);
figure(4);
imshow(HLtilde);
title('HLtilde');
axis off;
axis ('image');
print (figure(4),'2bd','-dpng');%writing out image for LaTeX purpose

%Pointwise multiplication
%girl2
g1 = ifft2(HLtilde.*fft2(g));
figure(5);
colormap(gray(256));
image(contraststretch(g1));
title('girl2 image after pointwise multiplication');
axis off;
axis ('image');
print (figure(5),'2be','-dpng');%writing out image for LaTeX purpose

%girl2Noise32Hi
g2 = ifft2(HLtilde.*fft2(gnh));
figure(6);
colormap(gray(256));
image(contraststretch(g2));
title('girl2Noise32Hi image after pointwise multiplication');
axis off;
axis ('image');
print (figure(6),'2bf','-dpng');%writing out image for LaTeX purpose

%girl2Noise32
g3 = ifft2(HLtilde.*fft2(gn));
figure(7);
colormap(gray(256));
image(contraststretch(g3));
title('girl2Noise32 image after pointwise multiplication');
axis off;
axis ('image');
print (figure(7),'2bg','-dpng');%writing out image for LaTeX purpose

%computing MSE
P=256;
Q=256;
sum2=0;
for m=1:256
    sum1=0;
    for n=1:256
        QP=(g(m,n)-g1(m,n))^2;
        sum1=sum1+QP;
    end
    sum2=sum2+sum1;
end
FinalMSE=sum2/(P*Q);
disp('Final MSE after filtering between original girl2 image and filtered girl2 image');
display(FinalMSE);

P=256;
Q=256;
sum2=0;
for m=1:256
    sum1=0;
    for n=1:256
        QP=(g(m,n)-g2(m,n))^2;
        sum1=sum1+QP;
    end
    sum2=sum2+sum1;
end
FMSE1=sum2/(P*Q);
disp('Final MSE after filtering between original girl2 and girl2Noise32Hi ');
display(FMSE1);

M=256;
N=256;
sum2=0;
for m=1:256
    sum1=0;
    for n=1:256
        NM=(g(m,n)-g3(m,n))^2;
        sum1=sum1+NM;
    end
    sum2=sum2+sum1;
end
FMSE2=sum2/(M*N);
disp('Final MSE between original girl2 and girl2Noise32 ');
display(FMSE2);

%computing ISNR
ISNR1=10*log(MSE1/FMSE1);
disp('ISNR before and after filtering of girl2Noise32Hi ');
disp('ISNR1=');
disp(ISNR1);

ISNR2=10*log(MSE2/FMSE2);
disp('ISNR before and after filtering of girl2Noise32 ');
disp('ISNR2=');
disp(ISNR2);

function fin=contraststretch(orgn)
    [m,n]=size(orgn);
    A=min(min(abs(orgn)));
    B=max(max(abs(orgn)));
    if A==B
        A=min(min((orgn)));
        B=max(max((orgn)));
    end
    P=(m-1)/(B-A);
    L=-1*A*((m-1)/(B-A));
    fin=zeros(m,n);
    for i=1:m
        for j=1:n
            fin(i,j)=P*orgn(i,j)+L;
        end
    end
end