%LASERSCAN_TEST
%
%   Author Davide Scaramuzza - davide.scaramuzza@ieee.org
%   ETH Zurich - April, 25, 2007
%   Edited by Micha de Groot, Harm Manders and Yuri Sturkenboom
%   University of Amsterdam - November 27, 2016

clc;
url = get_camera_url();

% -------------------------------------------------------------------------
% MOST IMPORTANT PARAMETERS
% -------------------------------------------------------------------------
% Rmax = 160;%        Max detectable distance, set to 160 pixels in VGA images.
%                     Rmax was already loaded when calling "calibrate_camera.m"
% Rmin = 77;%         Min detectable distance in pixels in VGA image
%                     Rmin was already loaded when calling "calibrate_camera.m"
alpha = 130;%          Radial distortion coefficient
height = 0.10;%       camera height in meters
Bwthreshold = 100;%   Threshold for segment the image into Black & white colors
angstep = 1.0;%       Angular step of the beam in degrees
axislimit = 0.2;%     Axis limit


% -------------------------------------------------------------------------
% MAIN
% -------------------------------------------------------------------------

% The camera's parameters are found by manual calibration
[Rmin, Rmax, center] = calibrate_camera();

%while 1
    tic;%                               Start counting elapsed time
    
    % an image is acquired
    snapshot = imread('example_a.jpg');

    % here the image is undistorted
    [undistortedimage, theta] = imunwrap(snapshot, center, angstep, Rmax, Rmin);

    % the image is then thresholded to find obstacles
    BWimg = img2bw(undistortedimage, Bwthreshold); 

    % returns a *vecotr* of distances for each of rho
    rho = getpixeldistance(BWimg, Rmin)

    figure;
    imagesc(snapshot);
    hold on;
    drawlaserbeam(center, theta, rho);
    hold off;

    % here the distance measurements are undistorted and plotted
    dist = undistort_dist_points(theta, rho, alpha, height);
    figure;
    draw_undistorted_beam(dist, theta, axislimit);

    sigmaRho = compute_stdDev(rho)

    % finally, the uncertainty for each distance measure is computed and plotted
    sigmaDist = compute_uncertainty(rho, sigmaRho, alpha, height);
    hold on;
    draw_uncertainty(dist, theta, sigmaDist);
    
    
% Compute the time per frame and effective frame rate.
    elapsedTime = toc;
    effectiveFrameRate = 1/elapsedTime;
%end


