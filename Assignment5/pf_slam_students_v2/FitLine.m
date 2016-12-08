%---------------------------------------------------------------------
% This function computes the parameters (r, alpha) of a line passing
% through input points that minimize the total-least-square error.
%
% Input:   XY - [2,N] : Input points
%          
% Output:  r, alpha: paramters of the fitted line

function [r, alpha] = FitLine(XY)
     
    % Compute the centroid of the point set (xmw, ymw) considering that 
    % the centroid of a finite set of points can be computed as
    % the arithmetic mean of each coordinate of the points.

    % XY(1,:) contains x position of the points
    % XY(2,:) contains y position of the points  

    xmw = sum(XY(1,:))/lenght(XY(1,:);
    ymw = sum(XY(2,:))/length(XY(2,:);

    % compute parameter alpha (see exercise pages)
    nom =-2* symsum(((XY(1,i) - xmw ) * (XY(2,i) - ymw)), i, 0, length(XY(1,:)));
    denom = symsum(((XY(2,i) - ymw ) ^ 2 - (XY(1,i) - xmw) ^ 2), i, 0, length(XY(1,:)));
    alpha = 0.5 * atan2(nom, denom);
      
    % compute parameter r (see exercise pages)
    r = xmw*cos(alpha) + ymw*sin(alpha);
      
    % Eliminate negative radii
    if r < 0,
      alpha = alpha + pi;
      if alpha > pi, alpha = alpha - 2 * pi; end
      r = -r;
    end;
  
return  % function FitLine
