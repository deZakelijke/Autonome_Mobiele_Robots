%LASERSCAN_TEST
%
%   Author Davide Scaramuzza - davide.scaramuzza@ieee.org
%   ETH Zurich - April, 25, 2007

clc;
url = get_camera_url();

% -------------------------------------------------------------------------
% MOST IMPORTANT PARAMETERS
% -------------------------------------------------------------------------
% Rmax = 160;%        Max detectable distance, set to 160 pixels in VGA images.
%                     Rmax was already loaded when calling "calibrate_camera.m"
% Rmin = 77;%         Min detectable distance in pixels in VGA image
%                     Rmin was already loaded when calling "calibrate_camera.m"
alpha = 95;%          Radial distortion coefficient, YOU MAY NEED TO TUNE THIS PARAMETER!!!!!!!!!!!!!!!!!!!!!!!!!!!!
height = 0.17;%       camera height in meters, YOU MAY NEED TO TUNE THIS PARAMETER!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Bwthreshold = 200;%   Threshold for segment the image into Black & white colors, YOU MAY NEED TO TUNE THIS PARAMETER!!!!!!!!!!!!!!!!!!!!!!!!!!!!
angstep = 1.0;%       Angular step of the beam in degrees
axislimit = 0.8;%     Axis limit

% -------------------------------------------------------------------------
% MAIN
% -------------------------------------------------------------------------
while 1
    tic;%                               Start counting elapsed time
    
    %snapshot = imread(url); %           Acquire image    
    snapshot = 'voorbeeldplaatje';
    
    
    % First 
    
    % READ THE PDF DOCUMENT AND FILL THIS LOOP 
    % REMEMBER THAT YOU HAVE TO FLIP THE IMAGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    
    
% Compute the time per frame and effective frame rate.
elapsedTime = toc;
effectiveFrameRate = 1/elapsedTime;
end