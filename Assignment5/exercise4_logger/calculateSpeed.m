% calculates the power for the wheels based on the speed and the circle the
% robot is driving on
function [speedRight, speedLeft] = calculateSpeed(mainSpeed, axisLength, ICC_Distance)
    omega = mainSpeed/ICC_Distance;
    
    speedRight = omega*(ICC_Distance + axisLength/2);
    speedLeft = omega*(ICC_Distance - axisLength/2);

end
