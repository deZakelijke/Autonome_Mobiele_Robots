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
load 'LabeledBlobSignatures.mat'
load 'UnlabeledBlobSignatures.mat'

testLengthL = length(PatStringsU);
testLengthB = length(PatStringsBlobU);

locations = unique(PlaceID);
probLocation = 1/length(PlaceID);

for j=1:testLengthL
    
    newObsL = PatStringsU{j};
    newObsB = PatStringsBlobU{j};
    probListL = [];
    probListB = [];
    
    for i=1:length(PlaceID)
        distL = abs(LevenshteinDistance(newObsL, PatStrings{i}));
        distB = abs(LevenshteinDistance(newObsB, PatStringsBlob{i}));
        lenL = length(PatStrings{i});
        lenB = length(PatStringsBlob{i});
        similarityL = (lenL - distL ) /lenL;
        similarityB = (lenB - distB ) /lenB;
%         roomQuantity = sum(PlaceID(:) == i);
%         probLocation =  roomQuantity/length(PlaceID);
        probL = similarityL * probLocation;
        probB = similarityB * probLocation;
        probListL = [probListL probL];
        probListB = [probListB probB];
       
    end
    probList = (probListL + probListB)/2;

    [M,I] = max(probList);
    Room = PlaceID(I);
%     for i=1:length(locations)
%         obsIndex = find(PlaceID ==  i);
%         obsIndex = obsIndex(1);
%         if I >= obsIndex
%             room = I;
%         end
%     end

    disp('[Testimage, Room] ');
    disp([j,Room]);
%     disp('Room is most likely: ');
%     disp(room);
 
end

end
