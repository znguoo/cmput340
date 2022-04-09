%Load the dataset char_c1.mat and mri_c1.mat given on the lab webpage
clear all;
close all;
%%Part 1- Character images
load char_c1.mat;
A=Achar;
%you can choose any column out of the given 7 columns
%Every column corresponds to an image
b=Bchar(:,4);
x1=A\b; %using built-in routine
x1=reshape(x1,[16,16])'; %Every image is 16*16 so you need to reshape the falttened images
%x1=imresize(x1,10); %You can use the following code to resize your image
f1 = figure;
subplot(2, 3, 1);
imshow(x1)
%%Let us add some random noise to the A matrix
A=imnoise(A,'gaussian',0.3);
x=A\b;
x=reshape(x,[16,16])';
figure(f1);
subplot(2, 3, 2);
imshow(x)
%%% Now add the same gaussian noise to the image x1 and write down your
%%% observation. Which image is closer to the original image? What could be
%%% the reason behind this?

%%% ################# Enter your code here ######## %%%
x1 = imnoise(x1,'gaussian',0.3);
figure(f1);
subplot(2, 3, 3);
imshow(x1);
title('X1 with noice');
%%% ################# END #################### %%



%% Part 2- For MRI images
load mri_c1.mat
A=Amri;
%you can choose any column out of the given 10 columns
%Every column corresponds to a slice of the CT image
b=Bmri(:,9);
x2=A\b; %using built-in routine
x2=reshape(x2,[32,32])';
%x2=imresize(x2,10); %You can use the following code to resize your image
f2 = figure;
subplot(2, 3, 1);
imshow(x2)

%%Let us add some random noise to the A matrix
A=imnoise(A,'gaussian',0.3);
x=A\b;
x=reshape(x,[32,32])';
figure(f2);
subplot(2, 3, 2);
imshow(x)
%%% Now add the same gaussian noise to the image x2 and write down your
%%% observation. Which image is closer to the original image? What could be
%%% the reason behind this?

%%% ################# Enter your code here ######## %%%
x2=imnoise(x2,'gaussian',0.3);
figure(f2);
subplot(2, 3, 3);
imshow(x2);
title('X2 with noice');
%%% ################# END #################### %%


%% Character Data
%%%% One of the datasets, char_c1.mat, contains sequence letters. What word does it spell out?

%%% ################# Enter your code here ######## %%%
%run lab1 q3_3b
%%% ################# END #################### %%