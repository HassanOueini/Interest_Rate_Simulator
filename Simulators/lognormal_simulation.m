function lognormal_simulation(r0, mu, sigma, T, N, M)
% Lognormal Model Simulation in MATLAB
% This function simulates interest rate paths using the lognormal model.
% 
% Inputs:
%   r0    - Initial short rate
%   mu    - Drift (mean return of the log process)
%   sigma - Volatility
%   T     - Time horizon (in years)
%   N     - Number of time steps
%   M     - Number of simulation paths

    dt = T / N;    % Time step size
    t = linspace(0, T, N+1); % Time grid

    % Pre-allocate matrix to store simulated paths
    r = zeros(M, N+1);
    r(:, 1) = r0; % Set initial rate for all paths

    % Generate paths using the lognormal model
    for i = 1:N
        dW = sqrt(dt) * randn(M, 1); % Brownian increments
        r(:, i+1) = r(:, i) .* exp((mu - 0.5 * sigma^2) * dt + sigma * dW);
    end
    
    % Analytical Mean for Lognormal (GBM)
    analytical_mean = r0 * exp(mu * t);
    
    % Simulated Mean for Lognormal
    simulated_mean = mean(r, 1);
    
    % Plot simulated paths
    figure;
    hold on;
    h1 = plot(t, analytical_mean, 'r--', 'LineWidth', 2); % Analytical mean
    h2 = plot(t, simulated_mean, 'k', 'LineWidth', 2);    % Simulated mean
    plot(t, r(1:5, :), 'LineWidth', 1);                    % Simulated paths
    xlabel('Time (years)');
    ylabel('Short Rate');
    title('Lognormal (Geometric Brownian Motion) Model: Simulated Interest Rate Paths');
    legend([h1, h2], {'Analytical Mean', 'Mean Path'}, 'Location', 'best');
    grid on;
    ylim([(0.75 * r0) (1.25 * r0)]);
    hold off; 
end