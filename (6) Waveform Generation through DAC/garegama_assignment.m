% Define the range of τ (tau)
tau = 0:150;

% Compute the constant term
C = 2*exp(-1.5) - exp(-3);

% Compute the τ-dependent term
term_tau = 2*exp(-0.01*tau) - exp(-0.02*tau);

% Define different values of j to plot
j_values = [0, 1, 2, 3, 4];  % Modify these as needed

% Create a new figure
figure;
hold on;

% Plot R(τ) for each j
for j = j_values
    R = (C^j) .* term_tau;
    plot(tau, R, 'LineWidth', 1.5, 'DisplayName', ['j = ' num2str(j)]);
end

% Add labels and legend (with LaTeX formatting for τ)
xlabel('\tau', 'Interpreter', 'latex');
ylabel('R(\tau)', 'Interpreter', 'latex');
