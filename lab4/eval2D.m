%This code is available in eval2D.m
% make sure you define n and mode

%test for time for both newton method and broyden's method

n = 10;
mode = 1;
ls=[0.5,0.5]';
t=rand(2,1); %Choose some random starting point.


clf;
plotRobot2D(ls,t);
hold off;

%test for difference between finite-difference J and analytic J
h=0.1;
J=fdJacob2D(ls,t,h);
disp("finite-difference J");
disp(J);

disp("analytic J");
[~,J1] = evalRobot2D(ls,t);
disp(J1);

while(1)
  
  desired=ginput(1)'; %Get desired position from user

  clf;
  plot(desired(1),desired(2),'*');
  hold on;
  plotRobot2D(ls,t,':');
  tic
  %Solve and display the position
  t=invKin2D(ls,t,desired,n,mode); 
  plotRobot2D(ls,t);
  hold off;
  toc
end




function [pos,J]=evalRobot2D(l,theta)

    % calculate f1 and f2 
    pos(1,1)=l(1)*cos(theta(1))+l(2)*cos(theta(1)+theta(2));
    pos(2,1)=l(1)*sin(theta(1))+l(2)*sin(theta(1)+theta(2));
    %df1/dtheta(1)
    J(1,1) = -l(1)*sin(theta(1)) - l(2)*sin(theta(1)+theta(2));
    %df1/dtheta(2)
    J(1,2) = -l(2)*sin(theta(1)+theta(2));
    %df2/dtheta(1)
    J(2,1) = l(1)*cos(theta(1)) + l(2)*cos(theta(1)+theta(2));
    %df2/dtheta(2)
    J(2,2) = l(2)*cos(theta(1)+theta(2));

end

function J=fdJacob2D(l,theta,h)
%based on the result, it is close enough for finite-difference to be used
%in the optimization. And the larger h, the larger the differences. If
%using very small h value, the difference can be neglected.

%benefit for using finite-difference approximation is that the 
%formula is less complicated and the required calcutaion is less
%than analytic derivation. 

    J1 = (evalRobot2D(l,theta+[h;0])-evalRobot2D(l,theta-[h;0]))/(2*h);
    J2 = (evalRobot2D(l,theta+[0;h])-evalRobot2D(l,theta-[0;h]))/(2*h);
    J = [J1 J2];   
end

function theta=invKin2D(l,theta0,pos,n,mode)
%Newton's method is more accurate and slightly faster than broyden's method
    if mode == 0 % Newton's method 
       for i =1:n
           [pos_a,J] = evalRobot2D(l,theta0);
           f = pos_a - pos;
           s = -J\f;
           theta = theta0 + s; 
           %terminate when the constraint is satisfied
           if abs(f) < 0.00001
              break;   
           end
           %update theta0
           theta0 = theta;
        end
    end

    if mode == 1 % Broyden's method 
        [pos_a, B] = evalRobot2D(l,theta0);
        for i = 1:n
            fb = pos_a - pos;
            s = -B\fb;
            theta = theta0 + s;
            
            [pos_b, ~] = evalRobot2D(l,theta);
            fb2 = pos_b - pos;
            y = fb2 - fb;
            
            B = B + ((y-B*s)*s')/(s'*s);
            
            %terminate when the constraint is satisfied
            if abs(fb) < 0.00001 
                break;
            elseif abs(fb2) < 0.00001
                break;
            end

            %update theta0
            theta0 = theta;
            pos_a = pos_b;
        end
    end
end