clear all;
close all;

load char_c1.mat;
A = Achar;    
B = Bchar;
[~,n] = size(Bchar);
for i = 1:n
    x = A\(B(:,i)); %similar to the code presented in demo
    x = reshape(x,[16,16])'; %size is 16x16
    subplot(1,n,i);
    imshow(x);
end