function sigma_dist = compute_uncertainty( rho, sigma_rho, alpha, height );

% sigma_dist = compute_uncertainty( rho, sigma_rho, alpha, height )
%
% Computes the error of the distance on the ground floor, given the error
% of the distance in the image plane using the camera model.


%--------------------------------------------------------------------------
    derD_Rho = height/alpha( 1.0 + tan(rho/alpha).^2);
    sigmaDist = derD_Rho * sigmaRho;

%--------------------------------------------------------------------------
end
