clc;
[cols,rows]=meshgrid(0:7,0:7);
I5=cos(2*pi/8*(1.5*cols+1.5*rows));
fprintf(1,'%s\n','Re[I5]:');
disp(round((real(I5) * 10^4)*10^(-4)));

subplot(2,2,1);
imshow(real(I5));
title('Real part of image I5');
fprintf(1,'%s\n','Im[I5]:');
disp(round((imag(I5) * 10^4)*10^(-4)));

subplot(2,2,2);
imshow(imag(I5));
title('Imaginary part of image I5');
h=sum(hist(I5,0:8)');

subplot(2,2,3);
bar(h);
title('Histogram for original image');

A=min(min(abs(I5)));
B=max(max(abs(I5)));

k=8;
J=zeros(8,8);
for m=1:8
    for n=1:8
        J(m,n)=(((k-1)/(B-A))*(I5(m,n)-A));
    end
end

%figure(4);
subplot(2,2,4);
imshow(J);
title('Full scale contrast stretch image I5');
print (figure(1),'Q5','-dpng');%writing out image for LaTeX purpose

%figure(1);colormap(gray(256));
%image('j');
y=fftshift(fft2(I5));
fprintf(1,'%s\n','Re[DFT(I5)]:');
disp(round((real(y) * 10^4)*10^(-4)));

fprintf(1,'%s\n','Im[DFT(I5)]:');
disp(round((imag(y) * 10^4)*10^(-4)));