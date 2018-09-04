clc;
[cols,rows]=meshgrid(0:7,0:7);
t=sqrt(-1);
I1=0.5*exp(t*2*pi/8*(2.0*cols+2.0*rows));
fprintf(1,'%s\n','Re[I1]:');
disp(round(real(I1) * 10^4)*10^(-4));

subplot(2,2,1);
imshow(real(I1));
title('Real part of image I1');
fprintf(1,'%s\n','Im[I1]:');
disp(round(imag(I1) * 10^4)*10^(-4));

subplot(2,2,2);
imshow(imag(I1));
title('Imaginary part of image I1');
h=sum(hist(I1,0:8)');

subplot(2,2,3);
bar(h);
title('Histogram for original image');

A=min(min(abs(I1)));
B=max(max(abs(I1)));
if A==B
    A=min(min(I1));
    B=min(min(I1));
end

k=8;
J=zeros(8,8);
for m=1:8
    for n=1:8
        J(m,n)=(((k-1)/(B-A))*(I1(m,n)-A));
    end
end

subplot(2,2,4);
imshow(J);
title('Full scale contrast image I1');
print (figure(1),'Q1','-dpng');%writing out image for LaTeX purpose

y=fftshift(fft2(I1));
fprintf(1,'%s\n','Re[DFT(I1)]:');
disp(round(real(y) * 10^4)*10^(-4));


fprintf(1,'%s\n','Im[DFT(I1)]:');
disp(round(imag(y) * 10^4)*10^(-4));