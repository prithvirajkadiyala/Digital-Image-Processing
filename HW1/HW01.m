% to read lena.bin image
fidLena = fopen('lena.bin','r');
[Lena,~] = fread(fidLena,[256,256],'uchar');

% to read peppers.bin image 
fidpeppers = fopen('peppers.bin','r');
[peppers,~] = fread(fidpeppers,[256,256],'uchar');

% to display lena image
Lena = Lena' ;% for trasnpose of the image
figure(1);colormap(gray(256));
image(Lena);
axis('image');
title('Original Lena Image');

% to display peppers image
peppers = peppers' ;% for transpose of the image
figure(2);colormap(gray(256));
image(peppers);
title('Original Peppers Image');

% defining new image J
J(1:256,1:128)=Lena(1:256,1:128);
J(1:256,129:256)=peppers(1:256,129:256);
figure(3);colormap(gray(256));
image(J);
title('Image J');


% defining new image K by swapping
K(1:256,1:128)=J(1:256,129:256);
K(1:256,129:256)=J(1:256,1:128);
figure(4);colormap(gray(256));
image(K);
title('Image K');

%to wriye out the Image J and K
print (figure(3),'LenaLeft','-dpng');
print (figure(4),'LenaRight','-dpng');
% to write lena image
print (figure(1),'LenaOut','-dpng'); % write figure as png
fidOut = fopen('Outfile.bin','w+');
LenaOut = Lena';
fwrite(fidOut,LenaOut,'uchar'); % write raw image data
fclose(fidLena);fclose(fidOut);

% to write peppers image
print (figure(2),'PeppersOut','-dpng'); % write figure as png
fidOut = fopen('Outfile.bin','w+');
peppersOut = peppers';
fwrite(fidOut,peppersOut,'uchar'); % write raw image data
fclose(fidpeppers);fclose(fidOut);
