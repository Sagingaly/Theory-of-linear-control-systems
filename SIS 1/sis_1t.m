% Given parameters
K = 1;
M = 10;
B = 1;

% Define system matrices
A = [0 1; -K/M -B/M];
B_matrix = [0; 1/M];
C = [1 0];
D = [0];

% State-space system
sys_ss = ss(A, B_matrix, C, D);

% Transfer function of the system
sys_tf = tf([1], [M B K]);

% Time vector for simulation
t = 0:0.01:10;

% Step response
figure;
step(sys_tf, t);
title('Step Response');

% Impulse response
figure;
impulse(sys_tf, t);
title('Impulse Response');


f = @(t, x) [x(2); (1/M)*(1 - B*x(2) - K*x(1))];
x0 = [0; 0];  

[t_ode, x_ode] = ode45(f, t, x0);


figure;
plot(t_ode, x_ode(:, 1));
xlabel('Time (s)');
ylabel('Position y(t)');

