close all;
%I made up totle 28 beams. see pictures in writeup.pdf
%matrix A based on my images
A=[[1 1 1 1  0 0 0 0  0 0 0 0  0 0 0 0];
[0 0 0 0  1 1 1 1  0 0 0 0  0 0 0 0];
[0 0 0 0  0 0 0 0  1 1 1 1  0 0 0 0];
[0 0 0 0  0 0 0 0  0 0 0 0  1 1 1 1];

[1 0 0 0  1 0 0 0  1 0 0 0  1 0 0 0];
[0 1 0 0  0 1 0 0  0 1 0 0  0 1 0 0];
[0 0 1 0  0 0 1 0  0 0 1 0  0 0 1 0];
[0 0 0 1  0 0 0 1  0 0 0 1  0 0 0 1];

[1 1 0 0  1 0 0 0  1 0 0 0  0 0 0 0];
[0 0 1 0  0 1 0 0  0 1 0 0  1 0 0 0];
[0 0 0 1  0 0 1 0  0 0 1 0  0 1 0 0];
[0 0 0 0  0 0 0 1  0 0 0 1  0 0 1 1];

[0 0 0 0  1 0 0 0  1 0 0 0  1 1 0 0];
[1 0 0 0  0 1 0 0  0 1 0 0  0 0 1 0];
[0 1 0 0  0 0 1 0  0 0 1 0  0 0 0 1];
[0 0 1 1  0 0 0 1  0 0 0 1  0 0 0 0];

[1 1 1 0  1 0 0 0  0 0 0 0  0 0 0 0];
[0 0 0 1  0 1 1 0  1 0 0 0  0 0 0 0];
[0 0 0 0  0 0 0 1  0 1 1 0  1 0 0 0];
[0 0 0 0  0 0 0 0  0 0 0 1  0 1 1 1];

[0 1 1 1  0 0 0 1  0 0 0 0  0 0 0 0];
[1 0 0 0  0 1 1 0  0 0 0 1  0 0 0 0];
[0 0 0 0  1 0 0 0  0 1 1 0  0 0 0 1];
[0 0 0 0  0 0 0 0  1 0 0 0  1 1 1 0];

[1 1 0 0  1 0 0 0  0 0 0 0  0 0 0 0];
[0 0 1 0  0 1 0 0  1 0 0 0  0 0 0 0];
[0 0 0 0  0 0 0 1  0 0 1 0  0 1 0 0];
[0 0 0 0  0 0 0 0  0 0 0 1  0 0 1 1];];

display(cond(A));

%all original b values, total 28
b = [13.00;15.00;8.00;14.79;14.31;3.81;18.00;12.00;6.00;10.51;16.13;7.04;5.13;6.92;15.00;8.05;7.91;4.68;10.00;14.00;21.00;5.00;23.00;8.00;25.00;26.00;12.00;28.00];

%remove 5,8,11,13,15,17,18,21,23,25,26,28 of b
new_b = [13.00;15.00;8.00;14.79;3.81;18.00;6.00;10.51;7.04;6.92;8.05;10.00;14.00;5.00;8.00;12.00];

%subset of matrix A
new_A=[A(1:3,:);A(4,:);A(6:7,:);A(9:10,:);A(12,:);A(14,:);A(16,:);A(19:20,:);A(22,:);A(24,:);A(27,:);];
display(cond(new_A)); %this may not be well-conditioned, might because of the order of matrix A are not well sorted because i made it up by not following any order.

%myLU routine
[L,U] = myLU(new_A);
% fwdSubst to solve for y
y = fwdSubst(L,new_b,1);
% backSubst to solve for x
x = backSubst(U,y);
f1 = figure;
figure(f1);
imshow(x,'InitialMagnification',1000);
title('x with myLU');

%matlab '\' operator
[L,U] = lu(new_A);
rst2=reshape(U\(L\new_b),[4,4]);
rst2=rst2';
f2 = figure;
figure(f2);
imshow(rst2,'InitialMagnification', 1000);
title('x with operator');



%LU factorization
function[L,U] = myLU(A)
    [x,y] = size(A); 
    [U,L] = elimMat(A,1);
    %this L is the matrix with all the multipliers after doing first col elimination,so all zeros above the diagonal
    %this U is the matrix A after first col elimination, so first col should be [1 0 0]
    
    %recursive the elimination steps
    for i = 2:x
        [mat_U,mat_L] = elimMat(U,i); %mat_L is the multipliers matrix after doing second col elimination
        L = L*mat_L; %combine first, second,etc mat_L
        U = mat_U; %U is the matrix A after being factorized, handeled under elimMat function
    end
end


%elimination
function[M,L] = elimMat(A,k)
    [x,y] = size(A);
    %this is the 'lower matrix'
    mat_L = eye(x,y);
    for i = 1:x
        if A(k,k) ~= 0
            mult = A(i,k) / A(k,k);
            if i>k    
                %compute multipliers for current column
                mat_L(i,k) = mult;  
                p = A(k,:)*mult; 
                A(i,:) = A(i,:)-p; %to get all zeors under the diagonal for Upper matrix
            end
        end
    end
    M = A; %upper matrix
    L = mat_L; %lower matrix
end

function y = fwdSubst(L,b,k)
%Foward substitution
    [m,n]=size(L);
    if ~exist('k')  % If first call no k param given, but k=1
        k=1;
    end

    y=b(k)/L(k,k); %L(k,k) always 1?

    if k < n % Recursion step
        % for first col, the pos we might change are all pos except (1,1)
        % for second col, the pos we might change are all pos except(1,2),(2,2) 
        % similar for the remaining
        l = [zeros(k,1);L(k+1:m,k)];
        y = [y;fwdSubst(L,b-y*l,k+1)];% dot product Ly=b, so y= (b-y*l)/l(k,k)
        
    end
end



function x = backSubst(U,y,k)
%backward substitution
    [m,~]=size(U);
    if ~exist('k')  %frist k=m
        k=m;
    end
  
    x=y(k)/U(k,k);
    if k > 1 % Recursion step

        %from backward direction, position above diagonal for the last row.
        %second recursion is the one before last row.
        %other pos are zeros, also 1 for the diagonal, so all set to 0
        u = [U(1:k-1,k);zeros(m-k+1,1)];
        x = [backSubst(U,y-x*u,k-1);x]; %dot product Ux=y, so x = (y-x*u)/u(k,k)
    end
end