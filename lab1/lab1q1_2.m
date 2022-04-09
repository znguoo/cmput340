% Sample script  that shows how to automate running problem solutions
close all;
clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a) Load an image using the imread command 
img = imread('image.jpeg'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% b) Display original image in the first spot of a 2 x 3 a grid layout
%    Check the imshow and subplot commands.

f1 = figure;
subplot(2, 3, 1);
imshow(img);
title('Original Lenna image');
pause();



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% c) Display a gray scale version of the image in position 2 of the grid.
%    help rgb2gray

figure(f1);
subplot(2, 3, 2);
img1=rgb2gray(img);
imshow(img1);
title('Gray scale Lenna image');
pause();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% d) Generate a new figure and ask user to manually select a region of the
%    image. Display the subimage in position 3 of the grid.
%    Hint--> getrect()

% Get user input on a newly dislayed image

% Make grid the current figure

% Display selected region. Note the last : which applies the cut
% over all 3 channels.
f2 = figure;
figure(f2);
imshow(img);
rect = getrect;
%x,y=(rect(1),rect(2)), width = rect(3), height= rect(4)
cut_image = imcrop(img,[rect(1) rect(2) rect(3) rect(4)]);
figure(1);
subplot(2,3,3)
imshow(cut_image);
title('Selected region');
pause();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% e) Create a function J = luminance_change(I, option, value) such that:
%   * When given the option 'c', image I's contrast will be modified by
%     the given value. Simple multiplication will achieve this.
%   * When given the option 'b', image I's brightness will be modified by
%     the given value. Simple addition will achieve this.
%  
%   Showcase your function by filling positions 4 and 5 in the grid

% Contrast change
figure(1);
img3 = luminance_change(img, 'c', 0.7);
subplot(2,3,4)
imshow(img3);
title('Reduced Contrast');
pause();

% Brightness change
figure(1);
img4 = luminance_change(img,'b',100);
subplot(2,3,5);
imshow(img4);
title('Increased Brightness');
pause();



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% f) BONUS: Display a version of the image after it's been blurred using a
%    Gaussian filter. Hint: imgaussfilt()
blur = imgaussfilt(img,15);
subplot(2,3,6);
imshow(blur);
title('Gaussian blurr');
pause();

%required user defined function J
function J = luminance_change(img,option,value)
    if option == 'c'
        J = img*value;
    elseif option == 'b'
        J = img+value;
    end
end