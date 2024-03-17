clear
clc

% Define the function and symbolic variable
syms x;

% Function 1 (Polynomial)
f = sin(x);
xi = pi/4;
xi1 = pi/3;

% Calculate True Value
true_value = double(subs(f, xi1));

% Define the initial approximation
n = 0;
approximation = double(subs(f, xi));

% Initialize error variables
Et = [];
Ea = [];

% Set tolerance level
tol = 0.000000002;

% Initialize previous approximation
prev_approximation = 0;

% Initialize table
table_data = cell(0, 5);

% Loop until the error is less than the tolerance or maximum iterations are reached
while true
    n = n + 1;
    
    % Compute the value of f(x) and its derivatives at xi
    f_val = double(subs(f, x, xi));
    f_deriv1 = double(subs(diff(f, x), x, xi));
    f_deriv2 = double(subs(diff(f, x, 2), x, xi));
    f_deriv3 = double(subs(diff(f, x, 3), x, xi));
    f_deriv4 = double(subs(diff(f, x, 4), x, xi));
    f_deriv5 = double(subs(diff(f, x, 5), x, xi));
    f_deriv6 = double(subs(diff(f, x, 6), x, xi));
    f_deriv7 = double(subs(diff(f, x, 7), x, xi));
    f_deriv8 = double(subs(diff(f, x, 8), x, xi));
    f_deriv9 = double(subs(diff(f, x, 9), x, xi));
    f_deriv10 = double(subs(diff(f, x, 10), x, xi));
    f_deriv11 = double(subs(diff(f, x, 11), x, xi));


    % Compute h
    h = xi1 - xi;

    % Compute Taylor series approximation term by term
    approximation = f_val;
    for i = 1:n
        switch i
            case 2
                approximation = approximation + f_deriv1 * h;
            case 3
                approximation = approximation + (f_deriv2 * h^2) / 2;
            case 4
                approximation = approximation + (f_deriv3 * h^3) / 6;
            case 5
                approximation = approximation + (f_deriv4 * h^4) / 24;
            case 6
                approximation = approximation + (f_deriv5 * h^5) / 120;
            case 7
                approximation = approximation + (f_deriv6 * h^6) / 720;
            case 8
                approximation = approximation + (f_deriv7 * h^7) / 5040;
            case 9
                approximation = approximation + (f_deriv8 * h^8) / 40320;
            case 10
                approximation = approximation + (f_deriv9 * h^9) / 362880;
            otherwise
                % No more terms to add
        end
    end

    % Calculate True Error
    Et(n) = ((true_value - approximation) / true_value) * 100;
    
    % Calculate Approximate Error
    if n > 1
        Ea(n) = (abs(approximation - prev_approximation) / approximation) * 100;
    else
        Ea(n) = NaN; % No previous approximation for the first iteration
    end
    

    
    % Add data to table
    table_data{n, 1} = n - 1;
    table_data{n, 2} = approximation;
    table_data{n, 3} = Et(n);
    table_data{n, 4} = Ea(n);
    table_data{n, 5} = 'Converged'; % Assume converged until proven otherwise
    

    
    % Check termination conditions
    if abs((approximation - prev_approximation) / approximation) < tol || n >= 10
        break;
    end
    
        % Store the previous approximation
    prev_approximation = approximation;
end

% Convert table data to a table
table_results = cell2table(table_data, 'VariableNames', {'Iteration', 'Approximation', 'True_Error', 'Approx_Error', 'Status'});

% Display the table
disp(table_results);
