clc;
fidcamera = fopen('camera.bin','r');
[camera,junk] = fread(fidcamera,[256,256],'uchar');

% to display camera image
camera = camera' ; % for trasnpose of the image

subplot(2,2,1);colormap(gray(256));
image(camera);
title('Original camera Image');
I1=camera;
cdft=fftshift(fft2(I1));

%new image J1
%magnitude of the centered dft
absJ1=abs(cdft);
argJ1=0;
k=round(absJ1*exp(1i*argJ1));
J1=ifft2(k);

subplot(2,2,2);
imshow(J1);
title('Image J1');

%full scale contrast stretch
h=sum(hist(J1,0:255)');

A=min(min(abs(J1)));
B=max(max(abs(J1)));

k=256;
J=zeros(256,256);

for m=1:256
    for n=1:256
        J(m,n)=(((k-1)/(B-A))*(J1(m,n)-A));
    end
end

%log-magnitude of J1
lmagn=log(J);
subplot(2,2,2);
imshow(real(lmagn));
title('Image J1 after log')

%new image J2
%phase of the centered dft
argJ2=atand(imag(cdft)/real(cdft));
absJ2=1;
J2=absJ2*(exp(1i*argJ2));
finJ2=ifft2(J2);

%full scale contrast stretch
h=sum(hist(finJ2,0:255)');

A=min(min(abs(finJ2)));
B=max(max(abs(finJ2)));

k=256;
J=zeros(256,256);
for m=1:256
    for n=1:256
        J(m,n)=(((k-1)/(B-A))*(finJ2(m,n)-A));
    end
end

subplot(2,2,3);
imshow(real(J));
title('image J2');
print (figure(1),'Q7','-dpng');%writing out image for LaTeX purpose
