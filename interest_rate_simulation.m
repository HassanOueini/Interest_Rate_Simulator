
function interest_rate_simulation()
    r0 = 0.03;
    theta = 0.05;
    sigma = 0.02;
    kappa = 0.1;
    mu_lognormal = 0.03;
    
    % Simulation Settings
    T = 1; % Time horizon in years
    N = 100; % Number of time steps
    M = 500; % Number of simulation paths
    
    % Call functions to simulate each model
    vasicek_simulation(r0, kappa, theta, sigma, T, N, M);
    cir_simulation(r0, kappa, theta, sigma, T, N, M);
    lognormal_simulation(r0, mu_lognormal, sigma, T, N, M);

end
