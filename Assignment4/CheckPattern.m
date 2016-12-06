function CheckPattern()

% Write your code here to compute the probability of localization using any
% map pattern (e.g. line patterns, blob patterns or fusion of these 2
% patterns).
text = 'Write your code here to compute the probability of localization using any map pattern';
disp(text);
text = '(e.g. line patterns, blob patterns or fusion of these 2 patterns).';
disp(text);
load 'LineSignatures.mat'

newObs = PatStrings{1};
sz = size(PatStrings,2);
label = PlaceID(1);

ProbMax = 0;

for i=1:3
   similarity = (length(newObs)+ LevenshteinDistance(newObs, PatStrings{i})) /length(newObs);
   
   prob = similarity * ;
   
end

end