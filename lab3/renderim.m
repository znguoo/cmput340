function [pos,J]=evalRobot2D(l,theta)

    % calculate x and y 
    pos(1,1)=l(1)*cos(theta(1))+l(2)*cos(theta(1)+theta(2));
    pos(2,1)=l(1)*sin(theta(1))+l(2)*sin(theta(1)+theta(2));
    
    J(1,1) = -l(1)*sin(theta(1)) - l(2)*sin(theta(1)+theta(2));
    J(1,2) = -l(2)*sin(theta(1)+theta(2));
    J(2,1) = l(1)*cos(theta(1)) + l(2)*cos(theta(1)+theta(2));
    J(2,2) = l(2)*cos(theta(1)+theta(2));
    
end