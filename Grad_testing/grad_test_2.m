
clear 

steps_no = 30;
z_depth = 5;
t_depth = 2*pi;

z_range = 0:z_depth/steps_no:z_depth;
t = 0:t_depth/steps_no:t_depth;

path = [
    1+sin(t);
    1+cos(t);
    z_range
];
[~, N] = size(path);
grad = zeros(1, N);
scores = zeros(1, N);
direction = zeros(size(path));

v1 = [0;0;0];                           % previous vector
scores(1) = score(path(1:3, 1));
for i = 2:N
    scores(i) = score(path(1:3, i));
    grad(i-1) = scores(i) - scores(i-1);
    
    p0 = path(1:3, i);                              % Current point
    p1 = path(1:3, i-1);                            % Previous point
    
    v1 = p0 - p1;
    if sum(v1) == 0
        direction(1:3, i-1) = v1;
    else
        direction(1:3, i-1) = grad(i-1)*v1/norm(v1);
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

quiver3(X, Y, Z, U, V, W, 'LineWidth', 0.75);

% plot gradient sums
X_mean = mean(X);
Y_mean = mean(Y);
Z_mean = mean(Z);
U_sum = sum(U);
V_sum = sum(V);
W_sum = sum(W);
k = 3/norm([U_sum; V_sum; W_sum]);

quiver3(X_mean, Y_mean, Z_mean, k*U_sum, k*V_sum, k*W_sum, 'LineWidth', 1);

quiver3(X_mean, Y_mean, Z_mean, -5-X_mean, -5-Y_mean, 10-Z_mean, 0.5, 'LineWidth', 1);

legend('AUV path', 'Measured gradient on path', 'Overall gradient', 'True gradient')

