%%Camera.bin
clc;
fidcamera = fopen('camera.bin','r');
[camera,junk] = fread(fidcamera,[256,256],'uchar');

% to display camera image
camera = camera' ; % for trasnpose of the image
subplot(2,3,1);colormap(gray(256));
image(camera);
title('Original camera Image');
I1=camera;
cdft=fftshift(fft2(I1));

%real part of centered dft
subplot(2,3,2);
imshow(real(cdft));
title('Real part centered DFT');

%imaginary part of centered dft
subplot(2,3,3);
imshow(imag(cdft));
title('Imaginary part centered DFT');
%full scale contrast stretch
h=sum(hist(cdft,0:255)');

A=min(min(abs(cdft)));
B=max(max(abs(cdft)));

k=256;
J=zeros(256,256);
for m=1:256
    for n=1:256
        J(m,n)=(((k-1)/(B-A))*(cdft(m,n)-A));
    end
end

%log-magnitude of the centered dft
magn=sqrt(real(J)*real(J)+imag(J)*imag(J));
lmagn=log(1+abs(magn));
subplot(2,3,4);
imshow(lmagn);
title('Log-Mag centered DFT')

%phase of the centered dft
ph=atand(imag(J)/real(J));
subplot(2,3,5);
imshow(ph);
title(' Phase part of centered DFT');
print (figure(1),'Camera','-dpng');%writing out image for LaTeX purpose

%%eyeR.bin
clc;
fideyeR = fopen('eyeR.bin','r');
[eyeR,junk] = fread(fideyeR,[256,256],'uchar');

% to display eyeR image
eyeR = eyeR' ; % for trasnpose of the image
subplot(2,3,1);colormap(gray(256));
image(eyeR);
title('Original eyeR Image');
I1=eyeR;
cdft=fftshift(fft2(I1));

%real part of centered dft
subplot(2,3,2);
imshow(real(cdft));
title('Real part centered DFT');

%imaginary part of centered dft
subplot(2,3,3);
imshow(imag(cdft));
title('Imaginary part centered DFT');

%full scale contrast stretch
h=sum(hist(cdft,0:255)');
A=min(min(abs(cdft)));
B=max(max(abs(cdft)));
k=256;
J=zeros(256,256);
for m=1:256
    for n=1:256
        J(m,n)=(((k-1)/(B-A))*(cdft(m,n)-A));
    end
end

%log-magnitude of the centered dft
magn=sqrt(real(J)*real(J)+imag(J)*imag(J));
lmagn=log(1+abs(magn));
subplot(2,3,4);
imshow(lmagn);
title('Log-Mag centered DFT')

%phase of the centered dft
ph=atand(imag(J)/real(J));
subplot(2,3,5);
imshow(ph);
title(' Phase part of centered DFT');
print (figure(1),'eyeR','-dpng');%writing out image for LaTeX purpose

%%salesman.bin
clc;
fidsalesman = fopen('salesman.bin','r');
[salesman,junk] = fread(fidsalesman,[256,256],'uchar');

% to display salesman image
salesman = salesman' ; % for trasnpose of the image
subplot(2,3,1);colormap(gray(256));
image(salesman);
title('Original salesman Image');
I1=salesman;
cdft=fftshift(fft2(I1));

%real part of centered dft
subplot(2,3,2);
imshow(real(cdft));
title('Real part centered DFT');

%imaginary part of centered dft
subplot(2,3,3);
imshow(imag(cdft));
title('Imaginary part centered DFT');

%full scale contrast stretch
h=sum(hist(cdft,0:255)');

A=min(min(abs(cdft)));
B=max(max(abs(cdft)));

k=256;
J=zeros(256,256);
for m=1:256
    for n=1:256
        J(m,n)=(((k-1)/(B-A))*(cdft(m,n)-A));
    end
end

%log-magnitude of the centered dft
magn=sqrt(real(J)*real(J)+imag(J)*imag(J));
lmagn=log(1+abs(magn));
subplot(2,3,4);
imshow(lmagn);
title('Log-Mag centered DFT')

%phase of the centered dft
ph=atand(imag(J)/real(J));
subplot(2,3,5);
imshow(ph);
title(' Phase part of centered DFT');
print (figure(1),'salesman','-dpng');%writing out image for LaTeX purpose

%%head.bin
clc;
fidhead = fopen('head.bin','r');
[head,junk] = fread(fidhead,[256,256],'uchar');

% to display head image
head = head' ; % for trasnpose of the image
subplot(2,3,1);colormap(gray(256));
image(head);
title('Original head Image');
I1=head;
cdft=fftshift(fft2(I1));

%real part of centered dft
subplot(2,3,2);
imshow(real(cdft));
title('Real part centered DFT');

%imaginary part of centered dft
subplot(2,3,3);
imshow(imag(cdft));
title('Imaginary part centered DFT');

%full scale contrast stretch
h=sum(hist(cdft,0:255)');
A=min(min(abs(cdft)));
B=max(max(abs(cdft)));
k=256;
J=zeros(256,256);
for m=1:256
    for n=1:256
        J(m,n)=(((k-1)/(B-A))*(cdft(m,n)-A));
    end
end

%log-magnitude of the centered dft
magn=sqrt(real(J)*real(J)+imag(J)*imag(J));
lmagn=log(1+abs(magn));
subplot(2,3,4);
imshow(lmagn);
title('Log-Mag centered DFT')

%phase of the centered dft
ph=atand(imag(J)/real(J));
subplot(2,3,5);
imshow(ph);
title(' Phase part of centered DFT');
print (figure(1),'Head','-dpng');%writing out image for LaTeX purpose
