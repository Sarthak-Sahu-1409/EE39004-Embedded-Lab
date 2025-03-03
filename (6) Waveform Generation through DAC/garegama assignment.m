% Define the range of k
k = 0:150;

% Compute the constant term
C = 2*exp(-1.5) - exp(-3);

% Compute the k-dependent term
term_k = 2*exp(-0.01*k) - exp(-0.02*k);

% Define different values of j to plot
j_values = [0, 1, 2, 3, 4];  % You can modify these values

% Create a new figure
figure;
hold on;

% Plot R(k) for each j
for j = j_values
    R = (C^j) * term_k;
    plot(k, R, 'LineWidth', 1.5, 'DisplayName', ['j = ' num2str(j)]);
end

% Add labels and legend
xlabel('k');
ylabel('R(k)');
title('Plot of R(k) = (2e^{-1.5} - e^{-3})^j \cdot (2e^{-0.01k} - e^{-0.02k})');
legend('show');
grid on;
hold off;