function CheckPattern()

% Write your code here to compute the probability of localization using any
% map pattern (e.g. line patterns, blob patterns or fusion of these 2
% patterns).
text = 'Write your code here to compute the probability of localization using any map pattern';
disp(text);
text = '(e.g. line patterns, blob patterns or fusion of these 2 patterns).';
disp(text);
load 'LabeledLineSignatures.mat'
load 'UnlabeledLineSignatures.mat'

testLength = length(PatStringsU);

for j=1:testLength
    
    newObs = PatStringsU{j};
    sz = size(PatStrings,2);
    locations = unique(PlaceID);
    probList = [];
    ProbMax = 0;
    
    for i=1:length(locations)
        obsIndex = find(PlaceID ==  i);
        obsIndex = obsIndex(1);
        PatStrings{obsIndex};
        dist = LevenshteinDistance(newObs, PatStrings{obsIndex});
        len = length(PatStrings{obsIndex});
        similarity = (len -dist ) /len;
        roomQuantity = sum(PlaceID(:) == i);
        probLocation =  roomQuantity/length(PlaceID);
        prob = similarity * probLocation;
        probList = [probList prob];
       
    end
    
    [M,I] = max(probList);
    disp('[Testimage, Room] ');
    disp([j,I]);
%     disp('Room is most likely: ');
%     disp(I);
    
end

end
