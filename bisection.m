clear 
clc
format long

% Define the function
f = @(x) -13 -20*x +19*x^2 -3*x^3;

% Define the interval [a, b]
a = -1;
b = 0;

% Set the tolerance level
tol = 0.01;
true_value = 0.904486720794046;

% Initialize variables
maxIterations = 1000;
iter = 0;
c = (a + b) / 2;
error = abs(b - a);

% Initialize arrays to store approximations, true errors, and approximate errors
approximations = zeros(1, maxIterations);
Et = zeros(1, maxIterations);
Ea = zeros(1, maxIterations);
c_bef =0;
% Iterate until the error is smaller than the tolerance level or maximum iterations are reached
while error > tol && iter < maxIterations
    iter = iter + 1;
    c = (a + b) / 2;
    fc = f(c);
    
    if f(a) * fc < 0
        b = c;
    elseif f(a) * fc > 0
        a = c;
    else
        break; % If f(c) = 0, we found the root
    end
    
    error = abs((c - c_bef)/c)*100;
    Ea(iter) = error;
    approximations(iter) = c;
    c_bef = c;
end

% Calculate true errors and approximate errors
for n = 1:iter
    Et(n) = ((true_value -  approximations(n)) / true_value) * 100;
end



% Create a table
results_table = table((1:iter)', approximations(1:iter)', Et(1:iter)', Ea(1:iter)', ...
    'VariableNames', {'Iteration', 'Approximation', 'True_Error', 'Approx_Error'});

% Display the table
disp(results_table);

% Display the result
fprintf('Root found at x = %.8f after %d iterations.\n', c, iter);
