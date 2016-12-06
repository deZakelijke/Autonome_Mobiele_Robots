function GetLinePattern(center, Rmax, Rmin)

NumStrings = 0;
PatStrings = {};
PatStringsU = {};
PlaceID = [];

ax = 0.8

training = input('Is it labeled or unlabeled data [l/u]:', 's');

imgNum = 1;
while imgNum < 9

  
  % Get user input for looping
  Option = input('Get a new scan [1/0] : ');
  if Option == 0, break; end
  NumStrings = NumStrings + 1;
  if training == 'l'
    PlaceID(NumStrings)= input('Which place [1/2/3] : ')
  end;
  
  % Get a new scan
  XY = GetNextScan(center, Rmax, Rmin, imgNum);
  XY = XY';
  
  % Plot raw scan
  figure(1), clf, axis([-ax ax -ax ax]), grid on; hold on;
  plot(XY(1,:), XY(2,:), 'r.');

  % Extract line segments
  [NLines, r, alpha, segend, seglen] = recsplit(XY);
  disp(fprintf('Number of extracted lines: %d\n', NLines));

  % Plot extracted segments
  figure(2), clf, axis([-ax ax -ax ax]), grid on; hold on;
  color = 0;
  for i=1:NLines
    if color == 0, c = 'r'; elseif color == 1, c = 'b'; else c = 'g'; end
    line([segend(i,1) segend(i,3)], [segend(i,2) segend(i,4)], ...
	 'color', c, 'linewidth', 3);
    color = mod(color+1, 3);
  end
  
  
  % Compute the string
  S = ComputePatStringLines(NLines, segend, seglen);
  disp(fprintf('Pattern string:  %s', num2str(S)));
  
  PatStrings{NumStrings} = S;
  % Store the pattern string and place ID
  %PatStrings{NumStrings} = S;
  imgNum = imgNum + 1;
end


% Save pattern strings and place id to output file
if training == 'l'
    save 'LabeledLineSignatures.mat' PatStrings PlaceID;
else 
    save 'UnlabeledLineSignatures.mat' PatStringsU;
end
close all
return

