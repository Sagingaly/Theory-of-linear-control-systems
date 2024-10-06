% System parameters
R1 = 1e3;         % Resistance in Ohms
C1 = 1e-6;        % Capacitance in Farads
L1 = 5e-6;        % Inductance in Henries
C2 = 10e-6;       % Capacitance in Farads

% Time parameters
dt = 0.001;              % Time step
t = 0:dt:10;             % Time vector from 0 to 10 seconds
N = length(t);           % Number of time steps

% Step input parameters
step_input = ones(1, N); % Step input (unit step function)

% Initialize voltages and currents
v_C1 = zeros(1, N);      % Voltage across C1
v_C2 = zeros(1, N);      % Voltage across C2
i_C1 = zeros(1, N);      % Current through C1

% Simulation for step input
for n = 2:N
    % Calculate current through C1 based on voltage change
    if n > 2
        i_C1(n) = C1 * (v_C1(n-1) - v_C1(n-2)) / dt; % Current through C1
    else
        i_C1(n) = C1 * (v_C1(n-1)) / dt; % For the first two iterations
    end
    
    % Update voltage across C1
    v_C1(n) = v_C1(n-1) + (step_input(n-1) - (v_C1(n-1)/(R1*C1))) * dt; 

    % Update voltage across C2
    v_C2(n) = v_C2(n-1) + (v_C1(n-1) - v_C2(n-1) / (L1 * C2)) * dt; 
end

% Plotting Step Response
figure;
subplot(2, 1, 1);
plot(t, v_C2, 'b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Output Voltage (V)');
title('Step Response');
grid on;

% Sinusoidal input parameters
A_sin = 5;                % Amplitude of sinusoidal input
w = 2 * pi * 1e3;         % Frequency in radians per second
phi = 45 * pi / 180;      % Phase in radians
u_sin = A_sin * cos(w * t + phi); % Generate sinusoidal input

% Initialize voltage for sinusoidal input simulation
v_C1_sin = zeros(1, N);   % Voltage across C1 for sinusoidal input
v_C2_sin = zeros(1, N);   % Voltage across C2 for sinusoidal input

% Simulation for sinusoidal input
for n = 2:N
    % Calculate current through C1 based on voltage change
    if n > 2
        i_C1_sin(n) = C1 * (v_C1_sin(n-1) - v_C1_sin(n-2)) / dt; % Current through C1
    else
        i_C1_sin(n) = C1 * (v_C1_sin(n-1)) / dt; % For the first two iterations
    end
    
    % Update voltage across C1 for sinusoidal input
    v_C1_sin(n) = v_C1_sin(n-1) + (u_sin(n-1) - (v_C1_sin(n-1)/(R1*C1))) * dt; 

    % Update voltage across C2 for sinusoidal input
    v_C2_sin(n) = v_C2_sin(n-1) + (v_C1_sin(n-1) - v_C2_sin(n-1) / (L1 * C2)) * dt; 
end

% Plotting Sinusoidal Response
subplot(2, 1, 2);
plot(t, v_C2_sin, 'r', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Output Voltage (V)');
title('Response to Sinusoidal Input');
grid on;
