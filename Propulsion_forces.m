% Script to estimate the force produced by one AUV thruster
% Propulsion is from Rule Bilge pump, rated at 12V, 3.7A, 4160 L/h

clear;

V = 12;                     % Max rated voltage (V)
I = 3.7;                    % Max rated current (A)
P_e = V*I;                  % Electrical power (W)

mu_m = 0.75;                % Electrical motor efficency
mu_p = 0.60;                % Propeller efficency
P = P_e * mu_m * mu_p;      % Propulsion power (W)

rho = 1000;                 % Density of water (kg/m^3)
r = 12.5e-3;                % Radius of pump exhaust (m)
A = pi * r^2;               % Pump CSA (m^2)
flow = 4160/3600;           % Water pump flow (liters/second)
volume_flow = flow/1000;    % Water volume flow (m^3/s)
v = (volume_flow / A);      % Water velocity (m/s)

F = 0.5 * rho * A * v^2;    % Force produced (N)
