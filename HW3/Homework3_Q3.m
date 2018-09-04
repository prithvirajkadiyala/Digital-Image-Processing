clc;
fidactontBin = fopen('actontBin.bin','r');
[actontBin,junk] = fread(fidactontBin,[256,256],'uchar');
actontBin = actontBin' ; % you must trasnpose the image
figure(1);colormap(gray(256));
image(actontBin);
title('Original actontBin Image');
axis image;
axis off;
print (figure(1),'Original_ActonBin','-dpng');%writing out image for LaTeX purpose

J=actontBin;
print -dtiff M_actontBin.tif; % write figure as tif
fidOut = fopen('Outfile.bin','w+');
actontBinOut = actontBin';
fwrite(fidOut,actontBinOut,'uchar'); % write raw image data
fclose(fidactontBin);fclose(fidOut);
I=zeros(26,14);
I(:,6:8)=255;
I(1:5,:)=255;
p=26;
q=14;
figure(2);
colormap(gray(256));
image(I);
title('Template');
axis image;
axis off;
print (figure(2),'Template','-dpng');%writing out image for LaTeX purpose

X=zeros(p,q);
k=1/(p*q);
for m=1:256-p
    for n=1:256-q
        X=~(xor(I,J(m:p+m-1,n:q+n-1)));
        X2(m,n)=sum(sum(X));
        X3(m,n)=k*X2(m,n);
    end
end
figure(3);
imshow(X3);
title('Output Image');
axis image;
axis off;
print (figure(3),'Output_Image','-dpng');%writing out image for LaTeX purpose

G=zeros(256,256);
for m=1:256-p
    for n=1:256-q
        if X3(m,n)>0.9
            G(m:m+p-1,n:n+q-1)=and(I,J(m:m+p-1,n:n+q-1));
        end
    end
end
figure(4);
imshow(G);
title('After thresholding the output image');
axis image;
axis off;
print (figure(4),'After_Threshlding_Image','-dpng');%writing out image for LaTeX purpose
