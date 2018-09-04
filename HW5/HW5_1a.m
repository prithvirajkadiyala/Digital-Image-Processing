clc;
clear all;
close all;

%Reading and displaying Salesman Image
salesman=fopen('salesman.bin','r');
s=fread(salesman,[256,256],'uchar');
s=s';
figure(1);
image(s);
title('Original Salesman');
axis off;
axis ('image');
print (figure(1),'1aa','-dpng');%writing out image for LaTeX purpose

colormap(gray(256));
fss=contraststretch(s);
figure(2);
image(fss);
axis off;
axis ('image');
title('Original salesman Image with full scale Stretch');

padsize=262;
ZPsalesman=zeros(padsize,padsize);
ZPsalesman(4:259,4:259)=s;
figure(3);
colormap(gray(256));
image(contraststretch(ZPsalesman));
title('Salesman man after Zeropadding and fullscale stretch');
axis off;
axis ('image');
print (figure(3),'1ab','-dpng');%writing out image for LaTeX purpose

%Final salesman
Finsalesman=zeros(256,256);
for s=1:256
    for j=1:256
        sum=0;
        for a=1:7
            for b=1:7
            sum=sum+ZPsalesman(s+a-1,j+b-1);
            end
        end
        Finsalesman(s,j)=sum/49;
    end
end

figure(4);
colormap(gray(256));
image(contraststretch(Finsalesman));
title('Final salesman after filtering and fullscale contrast');
axis off;
axis ('image');
print (figure(4),'1ac','-dpng');%writing out image for LaTeX purpose

function fin=contraststretch(orgn)
    [m,n]=size(orgn);
    A=min(min(abs(orgn)));
    B=max(max(abs(orgn)));
    if A==B
        A=min(min((orgn)));
        B=max(max((orgn)));
    end
    P=(m-1)/(B-A);
    L=-1*A*((m-1)/(B-A));
    fin=zeros(m,n);
    for i=1:m
        for j=1:n
            fin(i,j)=P*orgn(i,j)+L;
        end
    end
end