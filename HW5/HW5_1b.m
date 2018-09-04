clc;
clear all;
close all;
%Display Salesman Image
salesman=fopen('salesman.bin','r');
s=fread(salesman,[256,256],'uchar');
s=s';
figure(1);
colormap(gray(256));
fsstretch=contraststretch(s);
image(fsstretch);
title('Original salesman Image with full scale Stretch');
axis off;
axis ('image');
print (figure(1),'1ba','-dpng');%writing out image for LaTeX purpose


h=zeros(128,128);
h(62:68,62:68)=ones(7,7)/49;
figure(2);
Impresponse=contraststretch(h);
imshow(Impresponse);
title('Impulse response H');
axis off;
axis ('image');
print (figure(2),'1bb','-dpng');%writing out image for LaTeX purpose


%Zeropadding and creating ZPsalesman and ZPh
Padsize = 256+128-1;
ZPsalesman = zeros(Padsize,Padsize);
ZPsalesman(1:256,1:256) = s;
figure(3);
colormap(gray(256));
FZeroPaddedS=contraststretch(ZPsalesman);
image(FZeroPaddedS);
title('Zeropadded salesman Image');
axis off;
axis ('image');
print (figure(3),'1bc','-dpng');%writing out image for LaTeX purpose


ZPh = zeros(Padsize,Padsize);
ZPh(1:128,1:128) = h;
figure(4);
FZPh=contraststretch(ZPh);
colormap(gray(256));
image(FZPh);
title('Zeropadded H impulse reponse');
axis off;
axis ('image');
print (figure(4),'1bd','-dpng');%writing out image for LaTeX purpose


%Centered DFT of salesman and Impulse responseH
fSCDFT=fftshift(fft2(ZPsalesman));
SCDFT=(fft2(ZPsalesman));
SSCDFT=contraststretch(fSCDFT);
LOZDS=log(1+abs(SSCDFT));
figure(5);
imshow(LOZDS);
title('Centered DFT log mag of Zeropadded Salesman Image');
axis off;
axis ('image');
print (figure(5),'1be','-dpng');%writing out image for LaTeX purpose


%CODFT of H
fHCDFT= fftshift(fft2(ZPh));
HCDFT= (fft2(ZPh));
figure(6);
SHCDFT=contraststretch(fHCDFT);
LOZDH=log(1+abs(SHCDFT));
%imshow(HCDFT);
imshow(LOZDH);
title('Centered DFT log mag of Zeropadded H Image');
axis off;
axis ('image');
print (figure(6),'1bf','-dpng');%writing out image for LaTeX purpose


%convolution or pointwise multiplication
Z1 = real(ifft2(SCDFT .* HCDFT));
FZ1=contraststretch(Z1);
figure(7);
colormap(gray(256));
image(FZ1);
title(' Zeropadded Output Image');
axis off;
axis ('image');
print (figure(7),'1bg','-dpng');%writing out image for LaTeX purpose


%Final Output Image
Finalsalesman=FZ1(65:320,65:320);
figure(8);
colormap(gray(256));
image(Finalsalesman);
title('Salesman Final Output image after filtering and cropping');
axis off;
axis ('image');
print (figure(8),'1bh','-dpng');%writing out image for LaTeX purpose


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