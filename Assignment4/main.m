%%%% Your stating point for assignment 1 %%%%

% clear command window
clc;
close all;

% add needed pathes
path_setup = false;
if path_setup == false
    path_setup = true;
    addpath('./scans/');
    addpath('./Trainset AMR/');
    addpath('./Testset AMR/');
end

% Load calibrated camera settings
load 'WorkspaceDump.mat';

% Specify which steps should be followed,
% If first and last are same only that step is taken
first = 6;
last = 11;

for i=first:last
    step_num = i;
    %% steps 1-5: camera and scanning
    %% steps 6-10: localization experiment
    % 
    %% Step 1: Check camera Url
    % please check if the printed url is the correct for the camera
    % if not, edit it accordingly in the function 'get_camera_url'
    if step_num == 1
        url = get_camera_url();
        disp(url);
    end
    
    %% step 2: check if camera is working fine
    if step_num == 2
        test_camera();
    end
    
    %% step 3: calibrate the camera (only once)
    if step_num == 3
        [center, Rmax, Rmin] = calibrate_camera();
        % Only when new calibration
        %save 'WorkspaceDump.mat' center Rmax Rmin;
    end  
    
    %% step 4: test the camera calibration
    if step_num == 4
        % which graph do you want to display ('1', or '2')
        test_camera_calibrated('1', center, Rmax, Rmin);
    end  
    
    %% step 5: test image scanning (plotting boundaries)
    if step_num == 5
        % which graph do you want to display ('1', or '2')
        test_laserscan('1', center, Rmax, Rmin);
    end  
    
    %% step 6: get line pattern (i.e encoding) of the map
    if step_num == 6
        % hint: answer the command window instructions
       GetLinePattern(center, Rmax, Rmin);
       GetLinePattern(center, Rmax, Rmin);
    end
    
    %% step 7: test how distinctive the gathered line patterns
    if step_num == 7
        testPlaceLines();
    end
    
    %% step 8: get blob pattern (i.e encoding) of the map
    if step_num == 8
        % hint: answer the command window instructions
       GetBlobPattern(center, Rmax, Rmin);
       GetBlobPattern(center, Rmax, Rmin);
    end
    
    %% step 9: test how distinctive the gathered line patterns
    if step_num == 9
        disp('Calculating confidence matrix for blobs');
        testPlaceBlobs();
    end
    
    %% step 10: 
    if step_num == 10
        CheckPattern();
    end
    
    if step_num == 11
        kMeans()
    end

end
