
K = 0;
M1 = 3;
M2 = 1;
B1 = 1;
B2 = 10;
B3 = 1;


A = [0 1 0 0;
    -K/M1 -(B1+B3)/M1 K/M1 B3/M1;
    0 0 0 1;
    K/M2 B3/M2 -K/M2 -(B2+B3)/M2];

B = [0; 1/M1; 0; 0];  
C = [1 0 0 0];        
D = 0;               



sys = ss(A, B, C, D);

t = 0:0.01:10;


figure;
step(sys, t);
title('Step Response of the 2-DOF Mass-Spring System');
xlabel('Time (s)');
ylabel('y_1 (Displacement)');

% Impulse response
figure;
impulse(sys, t);
title('Impulse Response of the 2-DOF Mass-Spring System');
xlabel('Time (s)');
ylabel('y_1 (Displacement)');

% Numerical simulation using ODE45
% Define the ODE function for the system
odefun = @(t, x) A*x + B*1;  % Unit input (step input)
x0 = [0; 0; 0; 0];  % Initial conditions

% Solve the ODE using ode45
[t_ode, x_ode] = ode45(odefun, t, x0);

% Plot the ODE45 simulation result for y_1
figure;
plot(t_ode, x_ode(:,1));  % y_1 corresponds to the 1st state
xlabel('Time (s)');
ylabel('y_1 (Displacement)');
title('ODE45 Simulation of y_1');
