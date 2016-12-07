function kMeans()
    load 'LabeledBlobSignatures.mat';
    M = reshape(cell2mat(PatStringsBlob), [],90);

    idx = kmeans(M, 3)

end