function cir_simulation(r0, kappa, theta, sigma, T, N, M)
% Cox-Ingersoll-Ross Model Simulation in MATLAB
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
        % Ensure the square root term is non-negative
        sqrt_r = sqrt(max(r(:, i), 0)); % Avoid negative values under the square root
        dr = kappa * (theta - r(:, i)) * dt + sigma * sqrt_r .* dW;
        r(:, i+1) = r(:, i) + dr;
        % Ensure rates are non-negative
        r(:, i+1) = max(r(:, i+1), 0);
    end
    %Calculate the mean and 95% confidence interval of the simulated paths
    mean_path = mean(r); % Mean path
    std_path = std(r);   % Standard deviation of paths
    upper_ci = mean_path + 1.96 * std_path; % Upper 95% confidence interval
    lower_ci = mean_path - 1.96 * std_path; % Lower 95% confidence interval
    % Plot all simulated paths, mean path, and 95% confidence interval
    figure;
    hold on;
    % Plot all paths in light blue
    plot(t, r', 'Color', [0.4 0.6 1], 'LineWidth', 1);
    % Plot the mean path in red
    h_mean = plot(t, mean_path, 'r', 'LineWidth', 2);
    % Shade the 95% confidence interval in green
    h_ci = fill([t, fliplr(t)], [upper_ci, fliplr(lower_ci)], 'g', 'FaceAlpha', 0.2, 'EdgeColor', '#006400');
    % Add labels, title, and legend
    xlabel('Time (years)');
    ylabel('Short Rate');
    title('CIR Model: Simulated Interest Rate Paths');
    legend([h_mean, h_ci], {'Mean Path', '95% Confidence Interval'}, 'Location', 'best');
    grid on;
    % Dynamically set y-axis limits based on the range of the data
    y_min = min(r(:)) - 0.2 * abs(min(r(:))); % Add a small margin
    y_max = max(r(:)) + 0.2 * abs(max(r(:))); % Add a small margin
    ylim([y_min, y_max]);
    hold off;
end