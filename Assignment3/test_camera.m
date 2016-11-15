%**************************************************************************
%**************************************************************************
%TEST_CAMERA
%This script helps testing if the camera works propoerly.
%First checks the connected video device and set the image format (in this
%example we set a VGA resolution (640x480 pixels).
%
%   Author Davide Scaramuzza - davide.scaramuzza@ieee.org
%   ETH Zurich - April, 25, 2007
%**************************************************************************
%**************************************************************************

clc;
url = get_camera_url();
img  = imread(url);
img_disp = image(img);
while(1)
    img  = imread(url);
    set(img_disp,'CData',img);
    drawnow;
end