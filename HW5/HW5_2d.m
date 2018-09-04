clc;
close all;
clear all;

girl2=fopen('girl2.bin','r');
g=fread(girl2,[256,256],'uchar');
g=g';
figure(1);
colormap(gray(256));
image(contraststretch(g));
title('Original girl2 Image ');
axis off;
axis ('image');
print (figure(1),'2da','-dpng');%writing out image for LaTeX purpose

%
girl2Noise32Hi=fopen('girl2Noise32Hi.bin','r');
gnh=fread(girl2Noise32Hi,[256,256],'uchar');
gnh=gnh';
figure(2);
colormap(gray(256));
image(contraststretch(gnh));
title('Original girl2Noise32Hi Image ');
axis off;
axis ('image');
print (figure(2),'2db','-dpng');%writing out image for LaTeX purpose

%
girl2Noise32=fopen('girl2Noise32.bin','r');
gn=fread(girl2Noise32,[256,256],'uchar');
gn=gn';
figure(3);
colormap(gray(256));
image(contraststretch(gn));
title('Original girl2Noise32 Image ');
axis off;
axis ('image');
print (figure(3),'2dc','-dpng');%writing out image for LaTeX purpose

%Computing the MSE
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
disp('MSE between girl2 and girl2Noise32 ');
display(MSE2);

U_cutoff_H = 64;
SigmaH = 0.19 * 256 / U_cutoff_H;
[U,V] = meshgrid(-128:127,-128:127);
HtildeCenter = exp((-2*pi*SigmaH^2)/(256.^2)*(U.^2 + V.^2));
Htilde = fftshift(HtildeCenter);
H = ifft2(Htilde);
H2 = fftshift(H);
ZPH2 = zeros(512,512);
ZPH2(1:256,1:256) = H2;
ZPg1=zeros(512,512);
ZPg1(1:256,1:256)=g;
ZPgnh=zeros(512,512);
ZPgnh(1:256,1:256)=gnh;
ZPgn=zeros(512,512);
ZPgn(1:256,1:256)=gn;
g1 = real(ifft2(fft2(ZPH2).*fft2(ZPg1)));
g2 = real(ifft2(fft2(ZPH2).*fft2(ZPgnh)));
g3 = real(ifft2(fft2(ZPH2).*fft2(ZPgn)));
cg1=g1(129:384,129:384);
figure(5);
colormap(gray(256));
image(contraststretch(cg1));
title('Original girl2 image after filtering and cropping ');
axis off;
axis ('image');
print (figure(5),'2dd','-dpng');%writing out image for LaTeX purpose

cg2=g2(129:384,129:384);
figure(6);
colormap(gray(256));
image(contraststretch(cg2));
title('Original girl2Noise32Hi image after filtering and cropping ');
axis off;
axis ('image');
print (figure(6),'2de','-dpng');%writing out image for LaTeX purpose

cg3=g3(129:384,129:384);
figure(7);
colormap(gray(256));
image(contraststretch(cg3));
title('Original girl2Noise32 image after filtering and cropping ');
axis off;
axis ('image');
print (figure(7),'2df','-dpng');%writing out image for LaTeX purpose

M=256;
N=256;
sum2=0;
for m=1:256
    sum1=0;
    for n=1:256
        NM=(g(m,n)-cg1(m,n))^2;
        sum1=sum1+NM;
    end
    sum2=sum2+sum1;
end
FMSE=sum2/(M*N);
disp('Final MSE after filtering between original girl2 and filtered girl2 ');
display(FMSE);

M=256;
N=256;
sum2=0;
for m=1:256
    sum1=0;
    for n=1:256
        NM=(g(m,n)-cg2(m,n))^2;
        sum1=sum1+NM;
    end
    sum2=sum2+sum1;
end
FMSE1=sum2/(M*N);
disp('Final MSE after filtering between original girl2 and girl2Noise32Hi ');
display(FMSE1);

M=256;
N=256;
sum2=0;
for m=1:256
    sum1=0;
    for n=1:256
        NM=(g(m,n)-cg3(m,n))^2;
        sum1=sum1+NM;
    end
    sum2=sum2+sum1;
end
FMSE2=sum2/(M*N);
disp('final MSE between original girl2 and girl2Noise32 ');
display(FMSE2);
ISNR1=10*log(MSE1/FMSE1);
disp('ISNR before and after filtering of girl2Noise32Hi ');
disp('ISNR1='); disp(ISNR1);
ISNR2=10*log(MSE2/FMSE2);
disp('ISNR before and after filtering of girl2Noise32 ');
disp('ISNR2='); disp(ISNR2);

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