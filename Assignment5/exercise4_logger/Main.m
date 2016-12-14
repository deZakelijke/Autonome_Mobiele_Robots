% =================================================================
% 
%  Main.m
%  Closed-loop position control for differential-drive robots.
% 
%  The calling syntax is:
%       Main
%
%  Reference:
%  Introduction to: Autonomous Mobile Robots, Chapter 3.
% 
%  This is an M-file for MATLAB.  
%  Tested in: Matlab 7.1.0
%  Date: 12.04.07
%
% =================================================================*/

clc; % clear console


%===================================%
%   PARAMETERS TO CHANGE            %
%===================================%

% NUMBER OF SCANS:
N = 360;

% TIME BETWEEN TWO SNAPSHOTS:
T_b_S = 0.5;  %[s]

% FREQUENCY OF ODOMETRY UPDATE:
F_O_U = 5;  %[Hz]

% NAME OF THE LOG FILE:
Log_name = 'logCustom.txt';

%===================================%

%global PhiPrime Stop_Robot;
%global hSerial;


% INITIALIZE VARIABLES.
%InitVariables;
%InitCamera;

%robotData= GetRobotData(); % reads sensors and encoders
%encoder = robotData; % extracts encoder values

% Open the log file for writing the data
FILE = fopen(Log_name, 'w');
%henk = legoev3('wifi','10.42.0.109', '00165344fe29');
beep(henk)

mainSpeed = 15.0;

tic;
%figure(2)
iterations = 18;

motorRight = motor(henk, 'C');
motorLeft = motor(henk, 'B');

    
for i=1:iterations
    
    %% Each iteration 
    t_time = toc;
    [dx, dtheta] = OdometryCustom(i, mainSpeed, henk);
    SaveEncoderData(FILE, toc, dx, dtheta, N);    
    % scan
    % store
    disp('Taking laser data');
    laser_scans = GetLaserScans(N);
    SaveLaserData(FILE, toc, laser_scans);     
    
    
    %% DURING X SECONDS, THE ROBOT EVOLVES AND SAVE THE ODOMETRY MEASURES
    
%     while(rem_time>0 & ~Stop_Robot)
%         t_time = toc;
%         robotData = GetRobotData(); % retrieve data packet from NXT
%         [dEncoder, encoder] = GetEncoder(robotData, encoder); % get wheel encoder values
%         dS = dEncoder * robotConst(1); % calculate change in displacement from previous time step
%         [dx, dtheta]=Odometry(dS, robotConst(2)); % gets the odometry in the robot-centered reference system
%         SaveEncoderData(FILE, toc, dx, dtheta, N);
% 
%         SetSpeed(PhiPrime); % set the speeds of the motors
%         pause(1/F_O_U);
%         rem_time = rem_time - (toc - t_time);
%     end
    
end

stop(motorLeft);
stop(motorRight);

fclose(FILE);

%SetSpeed([0 0]);
pause(0.5);
%StopRobotCommunication();

display('Execution Complete!');
