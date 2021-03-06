function GetBlobPattern(center, Rmax, Rmin)

path(path, './scans/');
configfile_blobs;


% Loop - while the user wants, get image, compute pattern, store pattern
NumStrings = 0;
PatStringsBlob = {};
PatStringsBlobU = {};
PlaceID = [];

training = input('Is is labeled or unlabeld data [l\u]:', 's');

imgNum = 1;
while imgNum <= 8
	% Get user input for looping
	Option = input('Get a new image [1/0] : ');
	if Option == 0, break; end
	NumStrings = NumStrings + 1;
        if training == 'l'
	    PlaceNum = input('Which place [1/2/3] : ');
        end

    %url = get_camera_url();
	%img = imread(url);
    imgStr = num2str(imgNum);
    if training == 'l'
        fileName = strcat(imgStr, '.jpg');
    else
        fileName = strcat(imgStr, 'Test.jpg');
    end
    
    img = imread(fileName);
 	figure(12), clf; imshow(img);

	%% img center [row, col]
	img_center = center';
	radius = Rmax;
	radius_inner = Rmin;

	%% color segment
	[cl_angles, cl_center, cl_type] = color_segment(color_s, img, sat, lum, max_pxarea, min_pxarea, img_center, radius, radius_inner , stdthreshold);

	%% just to see
	rad2deg(cl_angles);
	hold on;
% 	plot([img_center(1, 2), img_center(1,2) + 100],[img_center(1,1), img_center(1,1)], 'y-');
% 	plot([img_center(1, 2), img_center(1,2)],[img_center(1,1), img_center(1,1) + 100], 'y-');
	plot([img_center(1, 1), img_center(1,1) + 100],[img_center(1,2), img_center(1,2)], 'y-');
	plot([img_center(1, 1), img_center(1,1)],[img_center(1,2), img_center(1,2) + 100], 'y-');
 
	if(isempty(cl_center) ~= 1)
		plot(cl_center(:, 2),  cl_center(:, 1), 'mx', 'MarkerSize', 5);
% 		plot(img_center(:, 2),  img_center(:, 1), 'mx', 'MarkerSize', 5);
% 		plot(cl_center(:, 1),  cl_center(:, 2), 'mx', 'MarkerSize', 5);
% 		plot(img_center(:, 1),  img_center(:, 2), 'mx', 'MarkerSize', 5);
	end

	%% compute pattern string
	%% warning: angle=0 is center -> left
	S = ComputePatStringBlobs( cl_angles , cl_type);
	disp(sprintf('BLOB Pattern string:  %s', num2str(S)));

        if training == 'l'
            PatStringsBlob{NumStrings} = S;
            PlaceID(NumStrings) = PlaceNum;
        else
            PatStringsBlobU{NumStrings} = S;
        end
    
    imgNum = imgNum + 1;
end

if training == 'l'
    save 'LabeledBlobSignatures.mat' PatStringsBlob PlaceID;
else
    save 'UnlabeledBlobSignatures.mat' PatStringsBlobU;
end
close all

end
