function dist = GetLaserScans(N, center, Rmax, Rmin)


%   GetLaserScans()
%
%   Author: Xavier Perrin - xavier.perrin@mavt.ethz.ch
%   Based on the work of Davide Scaramuzza - davide.scaramuzza@ieee.org
%   ETH Zurich - Mai, 4, 2007

% -------------------------------------------------------------------------
% MOST IMPORTANT PARAMETERS
% -------------------------------------------------------------------------

alpha = 120;%         Radial distortion coefficient
height = 0.1261;%     camera height in meters

% ------Old values ------
%alpha = 180;%         Radial distortion coefficient:  Robot ASL2: 112, other: 107
%         (it depends on the lens used... !)
%height = 0.09;%       camera height in meters
% ---------------------------

%BWthreshold = 0.45; %   Threshold for segment the image into Black & white colors
%angstep = 360/N;   %   Angular step of the beam in degrees
%axislimit = 0.2;   %   Axis limit

BWthreshold = 0.4; %   Threshold for segment the image into Black & white colors
angstep = 360/N;   %   Angular step of the beam in degrees
axislimit = 0.8;   %   Axis limit

%url = get_camera_url();
%snapshot = imread(url); %      Acquire image
snapshot = imread('example_a.jpg');
snapshot = imflipud( snapshot );%   Flip the image Up-Down

[undistortedimg, theta] = imunwrap( snapshot , center, angstep, Rmax, Rmin);% Transform omnidirectional image into a rectangular image
BWimg = im2bw( undistortedimg , BWthreshold ); % Binarize rectangular image into Blak&White
rho = getpixeldistance( BWimg , Rmin );%     Get radial distance (this distance is still affected by radial distortion)

figure(3);
imagesc(snapshot);
hold on;
drawlaserbeam( center, theta, rho ); %pause;

dist = undistort_dist_points( theta , rho , alpha , height );

% figure(2);
% draw_undisdtorted_beam( dist , theta , axislimit );
% drawnow;

% c = im2bw( grayimg , BWthreshold );
% figure(3); imagesc(c);
% colormap(gray);
% drawnow;

end

