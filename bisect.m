% Inputs:
% fun: A polynomial in the form of a function handle. Ex: @(x) x^2
% a: The left bound of the interval
% b: The right bound of the interval
% tol: When the difference between Cn+1 and Cn is less than this tolerance,
% the function exits as we have found the root
% nmax: The maximum number of iterations of calculating midpoints before stopping due to lack of convergence

% Outputs:
% n: The number of iterations required to find a root
% l: the final left bound before finding a root
% r: the final right bound before finding a root
% c: the final midpoint aka the root

% The following is an example of how this function might be called
% >> [n, l, r, c] = bisect(@(x)(x^3 + 2*x -6), 1, 2, 0.001, 100)

function [n, l, r, c] = bisect(fun, a, b, tol, nmax)

iterations = 0; % instantiate the iteration count used for ensuring the function eventually stops
if fun(a) * fun(b) > 0 % if 2 (-) or (+) are multiplied then the result will be greater than 0, meaning no root is between them
    n = 0; % No iterations have occurred so n is 0
    error('Evaluated endpoints have the same sign') % print to the user that the endpoints will not work
else
    midpoint0 = (a + b) / 2; % calculate the midpoint between the two bounds by adding them together then dividing by 2  
    iterations = iterations + 1; % increment the iteration count by 1
    while iterations <= nmax % while the number of iterations is less than or equal to the maxiumum allowed, continue executing
        if fun(a) * fun(midpoint0) < 0 % if the function at a and function at the midpoint multiplied is less than 0
            b = midpoint0; % The root must be between a and the midpoint, so the midpoint becomes the new b bound
        else % otherwise
            a = midpoint0; % The root must be between b and the midpoint, so the midpoint becomes the new a bound          
        end % end if else
        midpoint1 = (a + b)/2; % calculate the midpoint
        iterations = iterations + 1; % increment the iteration count by 1
        if (abs(midpoint1 - midpoint0) < tol) % If the difference between the new and old midpoints is less than the tolerance
            break; % break out of the while loop since we have found a root matching our precision
        end % end if
        if (iterations >= nmax) % if the iteration count reaches the maxiumum allowed number of iterations
            error('The maximum iterations have been reached without convergence'); % tell the user the max has been reached without convergence and exit
        end % end if
        midpoint0 = midpoint1; % assign the value of the new midpoint to the midpoint we use to evaluate functions
    end % end while
end % end if else

% ensure the output is correct by mapping the final values of the variables to the output variables
n = iterations; % n is the number of iterations before reaching a root
l = a; % l is the final left bound
r = b; % r is the final right bound
c = midpoint1; % c is the root

% print the output variables
fprintf('n is %d\n', n) % print n
fprintf('l is %d\n', l) % print l
fprintf('r is %d\n', r) % print r
fprintf('c is %d\n', c) % print c
