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
alpha = 65;%          Radial distortion coefficient, YOU MAY NEED TO TUNE THIS PARAMETER!!!!!!!!!!!!!!!!!!!!!!!!!!!!
height = 0.20;%       camera height in meters, YOU MAY NEED TO TUNE THIS PARAMETER!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Bwthreshold = 80;%   Threshold for segment the image into Black & white colors, YOU MAY NEED TO TUNE THIS PARAMETER!!!!!!!!!!!!!!!!!!!!!!!!!!!!
angstep = 1.0;%       Angular step of the beam in degrees
axislimit = 0.6;%     Axis limit


% -------------------------------------------------------------------------
% MAIN
% -------------------------------------------------------------------------

%[Rmin, Rmax, center] = calibrate_camera()
Rmin = 90;
Rmax = 185;
center = [417.5814 780.7099];
%while 1
    tic;%                               Start counting elapsed time
    
    snapshot = imread(url); %           acquire image    
    %snapshot = imread('example_a.jpg');
    
    [undistortedimage, theta] = imunwrap(snapshot, center, angstep, Rmax, Rmin);

    figure;
    imagesc(undistortedimage);
    colormap(gray);
    imshow(undistortedimage);
    
    % parameter needs fintetuning
    BWimg = img2bw(undistortedimage, Bwthreshold); 
    rho = getpixeldistance(BWimg, Rmin);
    imshow(BWimg, [0 1]);

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


    sigmaRho = compute_stdDev(rho);

    % finally, the uncertainty for each distance measure is computed and plotted
    sigmaDist = compute_uncertainty(rho, sigmaRho, alpha, height);
    hold on;
    draw_uncertainty(dist, theta, sigmaDist);
    
    
% Compute the time per frame and effective frame rate.
    elapsedTime = toc;
    effectiveFrameRate = 1/elapsedTime;
%end


