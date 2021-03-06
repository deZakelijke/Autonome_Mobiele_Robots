%% define hue space segmentation windows
%% str point, delta

% color_s = zeros(2,2);
% % green
% color_s(1,:) = [ 1.02974426, 3.05432619];
% % blue
% color_s(2,:) = [3.05432619, 4.6774824];
% 
% %% normalize it
% color_s = color_s/(2*pi);

% %% def values for saturation and luminance
% sat = [0.3 1];
% lum = [0.8 1];

%% define hue space segmentation windows
color_s = zeros(2,2);
% green
% color_s(1,:) = [0.3 0.4]; % green
color_s(1,:) = [0.01 .15];  %orange
% blue
% color_s(2,:) = [0.52 0.58];

color_s(2,:) = [50 100] / 360; % green
% color_s(2,:) = [180 225] / 360;  %blue
% color_s(2,:) = [200 320] / 360; % purple

%% def values for saturation and luminance
% sat = [0.3 1];  % use for green
% sat = [0.01 1];  % orange
sat = [0.01 0.4];  % orange
% lum = [0.3 0.95];
lum = [0.01 0.5];

%% min pxl area
% min_pxarea = 300;
min_pxarea = 5;
max_pxarea = 2000;

%% std threshold for color blob
stdthreshold = 20;