clc;

%Suzi1 open and read image
suzi=fopen('Suzi1.bin','r');
s=fread(suzi,[256,256],'uchar');
s=s'; %Transpose Image
figure(1);
colormap(gray(256)); %Converting into a Gray scale image
image(s); % Display image
title('Original Suzi Image');
axis ('image');
axis off;
print (figure(1),'OriginalSuzi','-dpng');

% Creating a histogram of the image
h=sum(hist(s,256)');
figure(2);
bar(h);
title('Histogram Image of Suzi1 image');
print (figure(2),'Histogram','-dpng');

t=92; %T=92.
J=s; %Making Dimensions of J equal to s
for i=1:255 % Loop for making values less than threshold to one.
    for j=1:255
        if s(i,j)>=t
            J(i,j)=0;
        else
            J(i,j)=255;
        end
    end
end

figure(3);
colormap(gray(256)); %Converting into a grayscale image
image(J) %Display the thresholded image
title('Image at Threshold T=92');
axis ('image');
axis off;
print (figure(3),'Threshold=92','-dpng');

%Blob_Coloring
R=zeros(256,256);
k=1;
extrarow=zeros(1,256); %Adding the extra Row
extracolumn=zeros(257,1); %Adding the extra Column
J=[extrarow;J];
J=[extracolumn J];
for i=2:256
    for j=2:256
        if J(i,j)==255 && J(i,j-1)==0 && J(i-1,j)==0 %Check condition 2 white blobs (Left and Top)
            R(i,j)=k; %R is the blob label
            k=k+1; % k is the blob number
        end
        if J(i,j)==255 && J(i,j-1)==0 && J(i-1,j)==255 %Check condition 1 white blob (Top)
            R(i,j)=R(i-1,j);
        end
        if J(i,j)==255 && J(i,j-1)==255 && J(i-1,j)==0 %Check condition for 1 white blob (Left)
            R(i,j)=R(i,j-1);
        end
        if J(i,j)==255 && J(i,j-1)==255 && J(i-1,j)==255 %Check condition for the case 4
            R(i,j)= R(i-1,j); % Both neighbouring blobs are the same
            if R(i,j-1)~=R(i-1,j)
                if R(i,j-1)< R(i-1,j)
                    kill=R(i-1,j);
                    keep = R(i,j-1);
                else
                    kill=R(i,j-1);
                    keep=R(i-1,j);
                end
                for ii=1:i-1 % Loop for changing the blob number R to the lowest
                    for jj=1:256
                        if R(ii,jj)==kill
                            R(ii,jj)=keep;
                        else
                            if R(ii,jj)> kill
                                R(ii,jj)=R(ii,jj)-1;
                            end
                        end
                    end
                end
                ii=i;
                for jj=1:j
                    if R(ii,jj)== kill
                        R(ii,jj)= keep;
                    else
                        if R(ii,jj) > kill
                        R(ii,jj)=R(ii,jj)-1;
                        end
                    end
                end
                k=k+1;
            end
        end
    end
end
figure(4);
colormap(gray(256)); %Converting into grayscale
image(R) %image after blob coloring
title('Resulting Image after Blob Coloring');
axis ('image');
axis off;
print (figure(4),'BlobColored','-dpng');

%Blob Counting%
count=zeros(1,k); % Making a matrix for count with k number of columns
for p= 1:k
    for i=1:255
        for j=1:255
            if R(i,j) == p
                count(1,p)=count(1,p)+1; %Counting the blobs
            end
        end
    end
    p = p+1;
end
%Maximum of all count
maximum = -50; % Any value compared will be stored
display(k);
for i = 1: k
    if count(i) > maximum 
        disp(count(i));
        disp(maximum);
        maximum = count(i);
        index = i; %This index refers to the index of the matrix with highest number of blobs
    end
end
disp(maximum);
disp(index);

%Minor Region Removal
for i = 1:255
    for j = 1:255
        if R(i,j) ~= index % If small blob then kill
            J(i,j) = 0;
        end
    end
end
figure(5);
colormap(gray(256)); %Converting into grayscale
image(J) %Display image
title('Image after Minor Region Removal');
axis ('image');
axis off;
print (figure(5),'MinorRegionRemoved','-dpng');

K=J;
for i=1:255
    for j=1:255
        if J(i,j)==255 %When there is a present pixel then replace with the original Suzi pixel
            K(i,j)=s(i,j);
        elseif J(i,j)==0
            K(i,j)=255;
        end
    end
end
figure(6);
colormap(gray(256)); %Converting into grayscale
image(K) %Display image
title('Image K');
axis ('image');
axis off;
print (figure(6),'ImageK','-dpng');