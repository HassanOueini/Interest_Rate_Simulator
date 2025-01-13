function cir_simulation(r0, kappa, theta, sigma, T, N, M)
% CIR Model Simulation in MATLAB
% This function simulates interest rate paths using the CIR model.
% 
% Inputs:
%   r0     - Initial short rate
%   kappa  - Speed of mean reversion
%   theta  - Long-term mean level
%   sigma  - Volatility
%   T      - Time horizon (in years)
%   N      - Number of time steps
%   M      - Number of simulation paths

    dt = T / N;     % Time step size
    t = linspace(0, T, N+1); % Time grid

    % Pre-allocate matrix to store simulated paths
    r = zeros(M, N+1);
    r(:, 1) = r0;  % Set initial rate for all paths

    % Generate paths using the CIR model SDE
    for i = 1:N
        dW = sqrt(dt) * randn(M, 1); % Brownian increments
        dr = kappa * (theta - r(:, i)) * dt + sigma * sqrt(r(:, i)) .* dW;
        r(:, i+1) = r(:, i) + dr;
        % Ensure rates are non-negative
        r(:, i+1) = max(r(:, i+1), 0);
    end

    % Analytical Mean for CIR
    analytical_mean = r0 * exp(-kappa * t) + theta * (1 - exp(-kappa * t));
    
    % Plot simulated paths
    figure;
    hold on;
    h1 = plot(t, analytical_mean, 'r--', 'LineWidth', 2);
    h2 = plot(t, mean(r), 'k', 'LineWidth', 2); % Plot the mean path
    plot(t, r(1:5, :), 'LineWidth', 1);
    xlabel('Time (years)');
    ylabel('Short Rate');
    title('Cox-Ingersoll-Ross (CIR) Model: Simulated Interest Rate Paths');
    legend([h1, h2], {'Analytical Mean', 'Mean Path'}, 'Location', 'best');
    grid on;
    ylim([(0.75 * r0) (1.25 * r0)]);
    hold off;
end
