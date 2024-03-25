
clc
clear
format long

% Define the function
% f = @(x) 2𝑥3−11.7𝑥2+17.7𝑥−5;

% Define the iteration function for simple fixed-point iteration
g = @(x) (-2*x^3 + 11.7*x^2  +5)/17.7; 

% Initial guess for the root
x0 = 3;

% Tolerance level
tol = 0.0000005;

% Maximum number of iterations
maxIterations = 1000;

% Calculate True Value
% true_value = 1.97238099813058;
true_value = 3.563160824862061;
% Initialize iteration counter and previous approximation
n = 0;
prev_approximation = x0;

% Initialize table
table_data = cell(0, 5);

% Loop until the error is less than the tolerance or maximum iterations are reached
while n < maxIterations
    n = n + 1;
    
    % Compute the next approximation using simple fixed-point iteration
    approximation = g(prev_approximation);

    % Calculate True Error
    Et = ((true_value - approximation) / true_value) * 100;
    
    % Calculate Approximate Error
    if n > 1
        Ea = (abs(approximation - prev_approximation) / approximation) * 100;
    else
        Ea = NaN; % No previous approximation for the first iteration
    end
    
    % Add data to table
    table_data{n, 1} = n - 1;
    table_data{n, 2} = approximation;
    table_data{n, 3} = Et;
    table_data{n, 4} = Ea;
    
    % Check convergence criteria
    if abs(approximation - prev_approximation) < tol
        table_data{n, 5} = 'Converged';
        break;
    else
        table_data{n, 5} = 'Not Converged';
    end
    
    % Store the previous approximation
    prev_approximation = approximation;
end

% Convert table data to a table
table_results = cell2table(table_data, 'VariableNames', {'Iteration', 'Approximation', 'True_Error', 'Approx_Error', 'Status'});

% Display the table
disp(table_results);
