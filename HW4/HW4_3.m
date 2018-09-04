clc;
I3=zeros(8,8);
[cols,rows]=meshgrid(0:7,0:7);
I3=cos(2*pi/8*(2.0*cols+2.0*rows));
fprintf(1,'%s\n','Re[I3]:');
disp(round(real(I3) * 10^4)*10^(-4));

subplot(2,2,1);
imshow(real(I3));
title('Real part of image I3');
fprintf(1,'%s\n','Im[I3]:');
disp(round(imag(I3) * 10^4)*10^(-4));

subplot(2,2,2);
imshow(imag(I3));
title('Imaginary part of image I3');
h=sum(hist(I3,0:8)');

subplot(2,2,3);
bar(h);
title('Histogram for original image');

A=min(min(abs(I3)));
B=max(max(abs(I3)));

k=8;
J=zeros(8,8);
for m=1:8
    for n=1:8
        J(m,n)=(((k-1)/(B-A))*(I3(m,n)-A));
    end
end

%figure(4);
subplot(2,2,4);
imshow(J);
title('Full scale contrast stretch image I3');
print (figure(1),'Q3','-dpng');%writing out image for LaTeX purpose

y=fftshift(fft2(I3));
fprintf(1,'%s\n','Re[DFT(I3)]:');
disp(round(real(y) * 10^4)*10^(-4));

fprintf(1,'%s\n','Im[DFT(I3)]:');
disp(round(imag(y) * 10^4)*10^(-4));