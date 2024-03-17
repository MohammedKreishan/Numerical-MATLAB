clear
clc

% Define the function and symbolic variable
syms x;

% Function (Change the function here)
f = 8*sin(x)* exp(-x)-1;

% Define the initial guess and other parameters
xi = 0.3;
tol = 0.0000000002;
maxIterations = 1000;

% Calculate True Value
true_value = double(subs(f, xi));

% Initialize iteration counter and previous approximation
n = 0;
prev_approximation = 0;

% Initialize table
table_data = cell(0, 5);

% Loop until the error is less than the tolerance or maximum iterations are reached
while true
    n = n + 1;
    
    % Compute the value of f(x) and its derivative at xi
    f_val = double(subs(f, x, xi));
    df_val = double(subs(diff(f, x), x, xi));
    
    % Compute the next approximation using Newton-Raphson method
    approximation = xi - f_val / df_val;

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
    
    % Check termination conditions
    if abs((approximation - prev_approximation) / approximation) < tol || n >= maxIterations
        table_data{n, 5} = 'Converged';
        break;
    else
        table_data{n, 5} = 'Not Converged';
    end
    
    % Store the previous approximation
    prev_approximation = approximation;
    
    % Update xi for the next iteration
    xi = approximation;
end

% Convert table data to a table
table_results = cell2table(table_data, 'VariableNames', {'Iteration', 'Approximation', 'True_Error', 'Approx_Error', 'Status'});

% Display the table
disp(table_results);
