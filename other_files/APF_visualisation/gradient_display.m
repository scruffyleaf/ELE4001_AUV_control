close all;

PLOT_GOAL = 0;
PLOT_OBSTACLE = 1;
WALL_FOLLOWER = 1;
STREAMLINES = 0;
VECTORS = 1;

STEP_SIZE = 20/15;

x = -10:STEP_SIZE:10;
y = -10:STEP_SIZE:10;
z = -5:STEP_SIZE:15;

[X, Y, Z] = meshgrid(x, y, z);

U = zeros(size(X));
V = zeros(size(X));
W = zeros(size(X));

for i = 1:(length(X)*length(Y)*length(Z))
    
    if (PLOT_GOAL == 1) && (PLOT_OBSTACLE == 1)
        obs_grad = obstacle_grad([X(i); Y(i); Z(i)]);
        scr_grad = score_grad([X(i); Y(i); Z(i)]);
        a = atan2(norm(cross(obs_grad, scr_grad)),dot(obs_grad, scr_grad)); % Angle between gradients
        k = a/pi;           % scaling factor
        grad =  k*obs_grad + (1-k)*scr_grad;
    elseif PLOT_OBSTACLE == 1
        if WALL_FOLLOWER == 1
            g = obstacle_grad([X(i); Y(i); Z(i)]);
            if sum(g) ~= 0
                grad = [
                    -sign(g(1))*g(3);
                    -sign(g(2))*g(3);
                    abs(g(1))+abs(g(2))
                ];
            else
                grad = [0;0;0];
            end
        else
            grad = obstacle_grad([X(i); Y(i); Z(i)]);
        end
    else
        grad = score_grad([X(i); Y(i); Z(i)]);
    end

    if norm(grad) > 1
        grad = grad / norm(grad);
    end
    
    U(i) = grad(1);
    V(i) = grad(2);
    W(i) = grad(3);
end

goal = [0; 3; 10];

obstacles = [
    -5,  2,  2, -5, -5; 
    -3, -3, -3, -3, -3; 
     9,  9,  2,  2, 9
];

% New figure
fig = figure;
xlim([min(x(1)), max(x(end))])
ylim([min(y(1)), max(y(end))])
zlim([min(z(1)), max(z(end))])

grid on;
hold on;

% plot and label goal
plot3(goal(1), goal(2), goal(3), 'om', 'linewidth', 3)
text(goal(1), goal(2), goal(3)-1, 'Goal', 'FontSize', 14)

% plot wall
fill3(obstacles(1, :), obstacles(2, :), obstacles(3, :), [0.6350 0.0780 0.1840])

if STREAMLINES == 1
    STREAM_STEPSIZE = 15/2;
    x1 = -10:STREAM_STEPSIZE:5;
    y1 = -10:STREAM_STEPSIZE:5;
    z1 = 0:STREAM_STEPSIZE:15;
        
    [X1, Y1, Z1] = meshgrid(x1, y1, z1);
    streamline(X, Y, Z, U, V, W, X1, Y1, Z1)
end

if VECTORS == 1
    colormap parula
    quiverC3D(X, Y, Z, U, V, W, 'Colorbar', true, 'LineWidth', 1)
end

view(75, 18)

xlabel('x')
ylabel('y')
zlabel('z')
legend({'goal', 'wall', 'gradient'}, 'location', 'northeast')

