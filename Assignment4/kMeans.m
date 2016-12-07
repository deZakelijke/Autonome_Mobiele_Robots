function kMeans()
    load 'LabeledBlobSignatures.mat';
    M = reshape(cell2mat(PatStringsBlob), [],90);

    disp('Calculate clusters by using K-means');
    disp('to see what images are from the same room');
    clusters = kmeans(M, 3)

end