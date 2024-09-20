% Parameters for the balancing platform and pendulum
m = 0.2;   % Mass of pendulum (kg)
M = 1.5;   % Mass of balancing platform (kg) - adjust accordingly
L = 0.8;   % Length of pendulum (m)
g = 9.81;  % Gravitational acceleration (m/s^2)
d = 0.05;  % Damping coefficient for platform

% State-space representation for balancing platform with pendulum
A = [0 1 0 0;
     0 -d/M -m*g/M 0;
     0 0 0 1;
     0 -d/(M*L) -(m+M)*g/(M*L) 0];
B = [0; 1/M; 0; 1/(M*L)];
C = [1 0 0 0];
D = 0;

% Create the state-space model
sys = ss(A,B,C,D);



% LQR design for balancing platform
Q = diag([100 1 10 1]);  % State cost matrix (adjust as necessary for platform)
R = 0.001;               % Control effort cost

K = lqr(A,B,Q,R);        % Compute LQR gains


A_cl = A - B*K;          % Closed-loop system dynamics with platform
sys_cl = ss(A_cl,B,C,D); % Closed-loop state-space model for platform

t = 0:0.01:10;           % Time vector
x0 = [0; 0; pi/4; 0];    % Initial conditions: pendulum angle, platform at rest

[Y,T,X] = initial(sys_cl,x0,t); % Simulate system with initial conditions

% Plot the platform position (or another object)
figure;
plot(T,Y);
xlabel('Time (s)');
ylabel('Platform Position (m)');
title('Platform Position with LQR Control');
grid on;

% Plot the pendulum angle
figure;
plot(T,X(:,3));  % X(:,3) corresponds to pendulum angle (theta)
xlabel('Time (s)');
ylabel('Pendulum Angle (rad)');
title('Pendulum Angle with LQR Control');
grid on;
