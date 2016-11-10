% Assignment 1 by Micha de Groot and Harm Manders


%henk = legoev3('USB');
function Assignment1()
%henk = legoev3('usb');
% Robot 03
%     henk = legoev3('wifi','10.42.0.131', '0016534397ff');
% Robot 05
%     henk = legoev3('wifi','10.42.0.131', '00165344ec79');
% Robot 012
    henk = legoev3('wifi','10.42.0.106', '0016534513f5');
    beep(henk)
    
    mainSpeed = 40.0;         % some unit, actually power to wheel, used as ground speed
    timeInterval = 0.1;     % in seconds
    runtime = 5;            % in seconds. Actual runtime is rt/ti
    orientation = [0,0,0];   % in cm and radials, location and angle with the origin of the initial frame
    axisLength = 12.5;      % in centimeters, approximation
    wheelRadius = 2.75;     % in centimeters, approximation
    ICC_Distance = -20.0;     % in centimeters
    straight = 12500000.0;    % ICC_D for straight
    
    motorRight = motor(henk, 'C');
    motorLeft = motor(henk, 'B');
    
    iterations = runtime/timeInterval;
    for i = 1: iterations
        if i < iterations * (1 / 4)
            ICC_Distance = straight;
        elseif i >= iterations * (1 / 4) && i < iterations * (3 / 8)
            ICC_Distance = 20;
        elseif i >= iterations * (3 / 8) && i < iterations * (1 / 2)
            ICC_Distance = straight;
        elseif i >= iterations * (1 / 2) && i < iterations * (5 / 8)
            ICC_Distance = -20;
        elseif i >=iterations * (5 / 8)
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
        
        if distanceRight == distanceLeft
            %angularRotation = 0;
            %iterationDistance = distanceRight;
            newRobotOrientation = [distanceRight,0.0,0.0];
        else
            angularRotation = double(calculateRotation(distanceRight, distanceLeft, axisLength));
            %iterationDistance = angularRotation * ICC_Distance;
            newRobotOrientation = [ cos(angularRotation) *ICC_Distance, sin(angularRotation)* ICC_Distance, angularRotation];
        end
        angle = double(orientation(3));
        rotationMatrix = [[cos(angle), sin(angle),0]; [-sin(angle), cos(angle),0]; [0,0,1]];
        
        newInitialOrientation = newRobotOrientation * rotationMatrix;
        orientation = orientation + newInitialOrientation;
    end
    
    stop(motorRight)
    stop(motorLeft)
    orientation
    
end

% calculates the power for the wheels based on the speed and the circle the
% robot is driving on
function [speedRight, speedLeft] = calculateSpeed(mainSpeed, axisLength, ICC_Distance)
    omega = mainSpeed/ICC_Distance;
    
    speedRight = omega*(ICC_Distance + axisLength/2);
    speedLeft = omega*(ICC_Distance - axisLength/2);

end

% Calculates the change in angle compared to the previous
% iteration/timeInterval
% This depends on how we have defined our initial system
function [angularRotation] = calculateRotation(distanceRight, distanceLeft, axisLength)
    angularRotation = (distanceRight - distanceLeft)/ axisLength;
end
