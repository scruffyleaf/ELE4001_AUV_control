
clear 

steps_no = 40;
z_lim = [0; 10];
t_depth = 2*pi;

z_range = z_lim(1):(z_lim(2)-z_lim(1))/steps_no:z_lim(2);
t = 0:t_depth/steps_no:t_depth;

path = [
    1+5*sin(t);
    1+5*cos(t);
    z_range
];
[~, N] = size(path);
grad = zeros(3, N);
direction = zeros(size(path));

v1 = [0;0;0];                           % previous vector
for i = 2:N
    grad(1:3, i-1) = score_grad(path(1:3, i));
    
    p0 = path(1:3, i);                              % Current point
    p1 = path(1:3, i-1);                            % Previous point
    
    v1 = p0 - p1;
    if sum(v1) == 0
        direction(1:3, i-1) = v1;
    else
        direction(1:3, i-1) = grad(1:3, i-1);
    end
end

% plot gradient directions
X = path(1, 1:N);
Y = path(2, 1:N);
Z = path(3, 1:N);
U = direction(1, 1:N);
V = direction(2, 1:N);
W = direction(3, 1:N);

% plot path
plot3(X, Y, Z, 'LineWidth', 0.75);

hold on
grid on

quiver3(X, Y, Z, U, V, W, 0.5, 'LineWidth', 0.75);

% plot gradient sums
X_mean = mean(X);
Y_mean = mean(Y);
Z_mean = mean(Z);
U_sum = sum(U);
V_sum = sum(V);
W_sum = sum(W);
k = 3/norm([U_sum; V_sum; W_sum]);

quiver3(X_mean, Y_mean, Z_mean, k*U_sum, k*V_sum, k*W_sum, 'LineWidth', 1);
quiver3(X_mean, Y_mean, Z_mean, 0-X_mean, 5-Y_mean, 10-Z_mean, 0.5, 'LineWidth', 1);
plot3(0, 5, 10, 'o')

legend('AUV path', 'Measured gradient on path', 'Overall gradient', 'True gradient')

