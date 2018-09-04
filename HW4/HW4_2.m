clc;
I2=zeros(8,8);
[cols,rows]=meshgrid(0:7,0:7);
t=sqrt(-1);
I2=0.5*exp(-t*2*pi/8*(2.0*cols+2.0*rows));
fprintf(1,'%s\n','Re[I2]:');
disp(round(real(I2) * 10^4)*10^(-4));

%figure(1);
subplot(2,2,1);
imshow(real(I2));
title('Real part of image I2');
fprintf(1,'%s\n','Im[I2]:');
disp(round(imag(I2) * 10^4)*10^(-4));

%figure(2);
subplot(2,2,2);
imshow(imag(I2));
title('Imaginary part of image I2');
h=sum(hist(I2,0:8)');

%figure(3);
subplot(2,2,3);
bar(h);
title('Histogram for original image');
A=min(min(abs(I2)));
B=max(max(abs(I2)));
if A==B
    A=min(min(I2));
    B=min(min(I2));
end

A=0.5;
B=5i;
k=8;
J=zeros(8,8);
for m=1:8
    for n=1:8
        J(m,n)=(((k-1)/(B-A))*(I2(m,n)-A));
    end
end

%figure(4);
subplot(2,2,4);
imshow(J);
title('Full scale contrast image I2');
print (figure(1),'Q2','-dpng');%writing out image for LaTeX purpose

y=fftshift(fft2(I2));
fprintf(1,'%s\n','Re[DFT(I1)]:');
disp(round(real(y) * 10^4)*10^(-4));

fprintf(1,'%s\n','Im[DFT(I1)]:');
disp(round(imag(y) * 10^4)*10^(-4));