% Calculates the change in angle compared to the previous
% iteration/timeInterval
% This depends on how we have defined our initial system
function [angularRotation] = calculateRotation(distanceRight, distanceLeft, axisLength)
    angularRotation = (distanceRight - distanceLeft)/ axisLength;
end