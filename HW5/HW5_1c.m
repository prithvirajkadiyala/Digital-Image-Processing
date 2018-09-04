clc;
clear all;
close all;

%Reading and displaying Salesman Image
salesman=fopen('salesman.bin','r');
s=fread(salesman,[256,256],'uchar');
s=s';
figure(1);
colormap(gray(256));
fin=contraststretch(s);
image(fin);
title('Original salesman Image with full scale Stretch');
axis off;
axis ('image');
print (figure(1),'1ca','-dpng');%writing out image for LaTeX purpose

ZPsalesman = zeros(512,512);
ZPsalesman(1:256,1:256) = s;
FZPsalesman=contraststretch(ZPsalesman);
figure(2);
colormap(gray(256));
image(FZPsalesman);
title('Zeropadded salesman image after fullscale contrast stretch');
axis off;
axis ('image');
print (figure(2),'1cb','-dpng');%writing out image for LaTeX purpose

%impulse response
H= zeros(256,256);
H(126:132,126:132)=ones(7,7)/49;
figure(3);
colormap(gray(256));
image(contraststretch(H));
title('Filter H after Zeropadding and full scale stretch');
axis off;
axis ('image');
print (figure(3),'1cc','-dpng');%writing out image for LaTeX purpose

H2=fftshift(H);
FH2=contraststretch(H2);
figure(4);
colormap(gray(256));
image(FH2);
title('H after fullscale stretch and shifting');
axis off;
axis ('image');
print (figure(4),'1cd','-dpng');%writing out image for LaTeX purpose

ZPH2 = zeros(512,512);
ZPH2(1:128,1:128) = H2(1:128,1:128);
ZPH2(1:128,385:512) = H2(1:128,129:256);
ZPH2(385:512,1:128) = H2(129:256,1:128);
ZPH2(385:512,385:512) = H2(129:256,129:256);
FZPH2= contraststretch(ZPH2);
figure(5);
colormap(gray(256));
image(FZPH2);
title('Final H');
axis off;
axis ('image');
print (figure(5),'1ce','-dpng');%writing out image for LaTeX purpose

Z1 = ifft2(fft2(ZPsalesman).*fft2(ZPH2));
Z1 = Z1(1:256,1:256);
figure(6);
colormap(gray(256));
image(contraststretch(Z1));
title('Final 256*256 Output image ');
axis off;
axis ('image');
print (figure(6),'1cf','-dpng');%writing out image for LaTeX purpose

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