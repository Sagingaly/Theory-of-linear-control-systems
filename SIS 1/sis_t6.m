% Define the coefficient matrix A
A = [6 9 7 5;
     6 4 7 3;
     4 5 3 2;
     4 3 8 2];

% Define the result vector b
b = [250; 195; 145; 125];

% Solve the system of linear equations using linsolve
x_linsolve = linsolve(A, b);

% Display the solution using linsolve
disp('Solution using linsolve:');
disp(x_linsolve);

% Solve the system using the inverse of A
x_inverse = inv(A) * b;

% Display the solution using inverse matrix method
disp('Solution using inverse matrix method:');
disp(x_inverse);

% Verification (the two solutions should be the same)
if isequal(round(x_linsolve, 4), round(x_inverse, 4))
    disp('Both solutions match.');
else
    disp('The solutions do not match.');
end
