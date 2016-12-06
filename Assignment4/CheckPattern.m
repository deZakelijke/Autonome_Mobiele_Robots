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

locations = unique(PlaceID);
sz = size(PatStrings,2);

for j=1:testLength
    
    newObs = PatStringsU{j};
    probList = [];
    ProbMax = 0;
    
    for i=1:length(PlaceID)
        dist = LevenshteinDistance(newObs, PatStrings{i});
        len = length(PatStrings{i});
        similarity = (len -dist ) /len;
        roomQuantity = sum(PlaceID(:) == i);
        probLocation =  roomQuantity/length(PlaceID);
        prob = similarity * probLocation;
        probList = [probList prob];
       
    end
    probList
    [M,I] = max(probList);
    
    for i=1:length(locations)
        obsIndex = find(PlaceID ==  i);
        obsIndex = obsIndex(1);
        if I >= obsIndex
            room = I;
        end
    end

    disp('Testimage: ');
    disp(j);
    disp('Room is most likely: ');
    disp(room);
 
   
end

end
