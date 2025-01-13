function vasicek_simulation(r0, kappa, theta, sigma, T, N, M)
% Vasicek Model Simulation in MATLAB
% This function simulates interest rate paths using the Vasicek model.
% 
% Inputs:
%   r0    - Initial short rate
%   theta     - Long-term mean level
%   kappa     - Speed of mean reversion
%   sigma - Volatility
%   T     - Time horizon (in years)
%   N     - Number of time steps
%   M     - Number of simulation paths

    dt = T / N;    % Time step size
    t = linspace(0, T, N+1); % Time grid

    % Pre-allocate matrix to store simulated paths
    r = zeros(M, N+1);
    r(:, 1) = r0; % Set initial rate for all paths

    % Generate paths using the Vasicek model SDE
    for i = 1:N
        dW = sqrt(dt) * randn(M, 1); % Brownian increments
        r(:, i+1) = r(:, i) + kappa * (theta - r(:, i)) * dt + sigma * dW;
    end
    
    % Analytical mean
    analytical_mean = r0 * exp(-kappa * t) + theta * (1 - exp(-kappa * t));



    % Plot a few simulated paths along with mean and analytical 
    figure;
    hold on;
    h1 = plot(t, analytical_mean, 'r--', 'LineWidth', 2);
    h2 = plot(t, mean(r), 'k', 'LineWidth', 2); % Plot the mean path
    plot(t, r(1:5, :), 'LineWidth', 1);
    xlabel('Time (years)');
    ylabel('Short Rate');
    title('Vasicek Model: Simulated Interest Rate Paths');
    legend([h1, h2], {'Analytical Mean', 'Mean Path'}, 'Location', 'best');
    grid on;
    ylim([(0.75 * r0) (1.25 * r0)]);  
    hold off;
end