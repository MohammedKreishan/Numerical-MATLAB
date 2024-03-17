clear 
clc

% Define the function
f = @(x) log(x^4)-0.7;

% Define the interval [a, b]
a = 0.5;
b = 2;

% Set the tolerance level
tol = 0.05;
% true_value = fzero(f, [a, b]);

% Initialize variables
maxIterations = 1000;
iter = 0;
error = abs(b - a);

% Initialize arrays to store approximations, true errors, and approximate errors
approximations = zeros(1, maxIterations);
Et = zeros(1, maxIterations);
Ea = zeros(1, maxIterations);

% Compute the function values at the interval endpoints
fa = f(a);
fb = f(b);
c_bef =0;

% Iterate until the error is smaller than the tolerance level or maximum iterations are reached
while error > tol && iter < maxIterations
    iter = iter + 1;
    
    % Compute the intermediate point using the false position method
%     c = (a * fb - b * fa) / (fb - fa);
    c = b - (fb*(a-b)/((fa - fb)));
    fc = f(c);
   
    
    % Update the interval [a, b]
    if fa * fc < 0
        b = c;
        fb = fc;
    elseif fa * fc > 0
        a = c;
        fa = fc;
    else 
        break
    end
    
    % Compute the error
    error = abs((((c - c_bef))/c))*100;
    c_bef = c;    
    % Store the approximation
    approximations(iter) = c;
end

% Calculate true errors and approximate errors
% for n = 1:iter
%     Et(n) = ((true_value -  approximations(n)) / true_value) * 100;
% end

for n = 2:iter
    Ea(n) = (abs(approximations(n) - approximations(n-1)) / approximations(n)) * 100;
end

% Create a table
results_table = table((1:iter)', approximations(1:iter)', Ea(1:iter)', ...
    'VariableNames', {'Iteration', 'Approximation', 'Approx_Error'});

% Display the table
disp(results_table);

% Display the result
% fprintf('Root found at x = %.8f after %d iterations.\n', c, iter);
