%to read JPEG file
J1=imread('lena512color.jpg');

%to display image J1
figure(1);
imshow(J1);
title('Color Image J1');

J2=J1;%condition for right size
J2(:,:,1)= J1(:,:,3);%Red band of J2= Blue band of J1
J2(:,:,2)= J1(:,:,1);%Green band of J2= Red band of J1
J2(:,:,3)= J1(:,:,2);%Blue band of J2= Green band of J1

%to display image J2
figure(2);
imshow(J2);
title('Different Bands of J1');

%to write it out input and output files as PNG file
print (figure(1),'Lena512Color','-dpng');
print (figure(2),'DiffColors','-dpng');

