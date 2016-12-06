function test_laserscan(graph_number, center, Rmax, Rmin)

% test_laserscan
%   Author Davide Scaramuzza - davide.scaramuzza@ieee.org
%   ETH Zurich - April, 25, 2007

% -------------------------------------------------------------------------
% MOST IMPORTANT PARAMETERS
% -------------------------------------------------------------------------
% Rmax = 160;%        Max detectable distance, set to 160 pixels in VGA images.
%                     Rmax was already loaded when calling "calibrate_camera.m"
% Rmin = 77;%         Min detectable distance in pixels in VGA image
%                     Rmin was already loaded when calling "calibrate_camera.m"
alpha = 112;%         Radial distortion coefficient
height = 0.17;%       camera height in meters
BWthreshold = 0.4;%   Threshold for segment the image into Black & white colors
angstep = 1;%         Angular step of the beam in degrees
axislimit = 0.8;%     Axis limit

% which graph to plot
graph_numbers = ['1', '2'];

% -------------------------------------------------------------------------
% MAIN
% -------------------------------------------------------------------------
while 1
    tic;%                               Start counting elapsed time    
    %url = get_camera_url(); 
    %snapshot  = imread(url);%     Acquire image
    snapshot = imread('example_a.jpg');
    snapshot = imflipud(snapshot);%   Flip the image Up-Down
    [undistortedimg, theta] = imunwrap(snapshot, center, angstep, Rmax, Rmin);% Transform omnidirectional image into a rectangular image
    BWimg = im2bw(undistortedimg, BWthreshold);% Binarize rectangular image into Blak&White
    rho = getpixeldistance(BWimg, Rmin);%     Get radial distance (this distance is still affected by radial distortion)
    
    if graph_number == graph_numbers(1)
        figure(1);
        imagesc(snapshot);
        hold on;
        drawlaserbeam(center, theta, rho);
        drawnow;
    end

    if graph_number == graph_numbers(2)
        figure(2);
        dist = undistort_dist_points(theta, rho, alpha, height);
        draw_undisdtorted_beam(dist, theta, axislimit);
        drawnow;
    end
    
    % if graph_number == graph_numbers(3)    
    %     figure(3);        
    %     c = im2bw(grayimg ,BWthreshold);
    %     imagesc(c);
    %     colormap(gray);
    %     drawnow;
    % end

    % Compute the time per frame and effective frame rate.
    % elapsedTime = toc;
    % effectiveFrameRate = 1/elapsedTime;
    % disp(effectiveFrameRate);
end

end