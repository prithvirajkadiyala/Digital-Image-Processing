clear all;
clc;

% using imread to call image J1
J1=imread('lenagray.jpg');

%display image J1
figure(1);
imshow(J1);
title('Image J1');

%display image J2
figure(2);
J2=255-J1;% condition to convert to photographic negative
imshow(J2);
title('Image J2');

% to write J1 & J2 as PNG file
print (figure(1),'LenaGray','-dpng');
print (figure(2),'LenaNegative','-dpng');
