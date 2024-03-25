clc
clear
% Define the function
f = @(x) -12*x^5 - 6*x^3 + 10;

% Initial guesses for the root
x0 = 0;
x1 = 01;

% Tolerance level
tol = 0.005;

% Maximum number of iterations
maxIterations = 1000;

% Calculate True Value
true_value = f(x0);

% Initialize iteration counter and previous approximations
n = 0;
prev_approximation = x0;

% Initialize table
table_data = cell(0, 5);

% Loop until the error is less than the tolerance or maximum iterations are reached
while n < maxIterations
    n = n + 1;
    
    % Compute the values of f(x) at x0 and x1
    f_x0 = f(x0);
    f_x1 = f(x1);
    
    % Compute the next approximation using the secant method
    approximation = x1 - f_x1 * (x0-x1) / (f_x0 - f_x1);

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
    if abs((approximation - prev_approximation) / approximation) < tol
        table_data{n, 5} = 'Converged';
        break;
    else
        table_data{n, 5} = 'Not Converged';
    end
    
    % Store the previous approximation
    prev_approximation = approximation;
    
    % Update x0 and x1 for the next iteration
    x0 = x1;
    x1 = approximation;
end

% Convert table data to a table
table_results = cell2table(table_data, 'VariableNames', {'Iteration', 'Approximation', 'True_Error', 'Approx_Error', 'Status'});

% Display the table
disp(table_results);
