fidMammogram = fopen('Mammogram.bin','r');
[Mammogram,junk] = fread(fidMammogram,[256,256],'uchar');
Mammogram = Mammogram' ; % you must trasnpose the image
figure(1);
colormap(gray(256));
image(Mammogram);
axis image;
axis off;
title('Original Mammogram Image');
print -dtiff M_Mammogram.tif; % write figure as tif
print (figure(1),'Original Mammogram','-dpng');%writing out image for LaTeX purpose
fidOut = fopen('Outfile.bin','w+');
MammogramOut = Mammogram';
fwrite(fidOut,MammogramOut,'uchar'); % write raw image data
fclose(fidMammogram);
fclose(fidOut);
T=96;
J = 255 * (Mammogram >= T);
figure(2);
colormap(gray(256));
image(J);
title('Threshold Image');
axis image;
axis off;
print (figure(2),'Thresholded Mammogram','-dpng');%writing out image for LaTeX purpose
G=zeros(256,256);
for m=2:255
    for n=2:255
        if J(m,n)==0
            if J(m-1,n)==255 || J(m,n-1)==255 || J(m,n+1)==255 || J(m+1,n)==255
                G(m,n)=255;
            end
        end
    end
end
figure(3);
colormap(gray(256));
image(G);
title('Approximate contour representation');
axis image;
axis off;
print (figure(3),'Approximate Contour','-dpng');%writing out image for LaTeX purpose