clc;
I4=zeros(8,8);
[cols,rows]=meshgrid(0:7,0:7);
%t=sqrt(-1);
I4=sin(2*pi/8*(2.0*cols+2.0*rows));
%j=fft(I1);
fprintf(1,'%s\n','Re[I4]:');
disp(round(real(I4) * 10^4)*10^(-4));

%figure(1);
subplot(2,2,1);
imshow(real(I4));
title('Real part of image I4');
fprintf(1,'%s\n','Im[I4]:');
disp(round(imag(I4) * 10^4)*10^(-4));

%figure(2);
subplot(2,2,2);
imshow(imag(I4));
title('Imaginary part of image I4');
h=sum(hist(I4,0:8)');

%figure(3);
subplot(2,2,3);
bar(h);
title('Histogram for original image');
A=min(min(abs(I4)));
B=max(max(abs(I4)));
k=8;
J=zeros(8,8);
for m=1:8
    for n=1:8
        J(m,n)=(((k-1)/(B-A))*(I4(m,n)-A));
    end
end

%figure(4);
subplot(2,2,4);
imshow(J);
title('Full scale contrast stretch image I4');
print (figure(1),'Q4','-dpng');%writing out image for LaTeX purpose


y=fftshift(fft2(I4));
fprintf(1,'%s\n','Re[DFT(I4)]:');
disp(round(real(y) * 10^4)*10^(-4));

fprintf(1,'%s\n','Im[DFT(I4)]:');
disp(round(imag(y) * 10^4)*10^(-4));