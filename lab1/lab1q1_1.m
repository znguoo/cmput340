close all;
% Vectorize the following
% Note the use of the tic/toc calls to time execution
% Compare the time once you have vectorized it

tic
for i = 1:1000
    t(i) = 2*i;
    y(i) = sin (t(i));
end
toc

clear;
% time elapsed is 0.00375 seconds

tic
    t = 2:2:1000;
    y = sin(t);
toc

clear;
%time elaspsed is 0.000025 seconds