function probability = probabilityOfObservation(Patterns, newObs, probOfLocation, len)
    probability = 0
    for i=1:length(Patterns)
        similarity = (len - abs(LevenshteinDistance(newObs, Patterns{i})))/len 
        probability += similarity * probOfLocation
    end

end
