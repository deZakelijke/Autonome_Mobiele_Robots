function [dx, dtheta] = OdometryCustom(i, mainSpeed, henk)
    timeInterval = 0.1;
    turnLeft = 10.0;
    %turnRight = -10.0;
    straight = 12500000000.0;    % ICC_D for straight
    
    axisLength = 12.5;      % in centimeters, approximation
    wheelRadius = 2.75;     % in centimeters, approximation

    motorRight = motor(henk, 'C');
    motorLeft = motor(henk, 'B');
    
    if i< 5
        mainSpeed = 0;
        ICC_Distance = straight;
    elseif i < 10
        ICC_Distance = straight;
    elseif i < 18
        ICC_Distance = turnLeft;
    else
        ICC_Distance = straight;
    end
    
    [motorRightSpeed, motorLeftSpeed] = calculateSpeed(mainSpeed, axisLength, ICC_Distance);
    motorRight.Speed = motorRightSpeed;
    motorLeft.Speed = motorLeftSpeed;

    start(motorRight)
    start(motorLeft)
    pause(timeInterval); 
    
    distanceRight = double(readRotation(motorRight))*wheelRadius;
    distanceLeft = double(readRotation(motorLeft))*wheelRadius;

    dx = (distanceRight + distanceLeft)/2;
    dtheta = tan((distanceRight - distanceLeft) / axisLength);  % current orientation
    dtheta = Set2range(dtheta);
   %stop(motorLeft);
    %stop(motorRight);
     
end