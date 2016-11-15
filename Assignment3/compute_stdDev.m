function [sigmaRho] = compute_stdDev(rho)
    rhoVect = reshape(rho,1)
    meanRho = sum(rho)/size(rho);
    sigmaRho = sqrt((sum(rho-meanRho).^2)./(size(rho)-1));
end
