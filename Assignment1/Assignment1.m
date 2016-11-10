% Assignment 1 by Micha de Groot and Harm Manders


%henk = legoev3('USB');
function Assignment1()
%henk = legoev3('usb');
% Robot 03
%     henk = legoev3('wifi','10.42.0.131', '0016534397ff');
% Robot 05
     henk = legoev3('wifi','10.42.0.131', '00165344ec79');
    
    beep(henk)
    
    mainSpeed = 40;         % some unit, actually power to wheel, used as ground speed
    timeInterval = 0.1;     % in seconds
    runtime = 10;            % in seconds. Actual runtime is rt/ti
    %angle = 0;              % in radials, ICC
    axisLength = 12.5;      % in centimeters, approximation
    %wheelRadius = 2.75;     % in centimeters, approximation
    ICC_Distance = -20;      % in centimeters
    straight = 12500000        % ICC_D for straight
    
    motorRight = motor(henk, 'C');
    motorLeft = motor(henk, 'B');
    
    iterations = runtime/timeInterval
    for i = 1: iterations
        if i < iterations * (1 / 4)
            ICC_Distance = straight
        elseif i >= iterations * (1 / 4) & i < iterations * (3 / 8)
            ICC_Distance = 20
        elseif i >= iterations * (3 / 8) & i < iterations * (1 / 2)
            ICC_Distance = straight
        elseif i >= iterations * (1 / 2) & i < iterations * (5 / 8)
            ICC_Distance = -20
        elseif i >=iterations * (5 / 8)
            ICC_Distance = straight
        end
            
        
        
        [motorRightSpeed, motorLeftSpeed] = calculateSpeed(mainSpeed, axisLength, ICC_Distance);

        motorRight.Speed = motorRightSpeed;
        motorLeft.Speed = motorLeftSpeed;

        start(motorRight)
        start(motorLeft)
        pause(timeInterval);
        
    end
    stop(motorRight)
    stop(motorLeft)
    
    
end

function [speedRight, speedLeft] = calculateSpeed(mainSpeed, axisLength, ICC_Distance)
    omega = mainSpeed/ICC_Distance;
    
    speedRight = omega*(ICC_Distance + axisLength/2);
    speedLeft = omega*(ICC_Distance - axisLength/2);

end
