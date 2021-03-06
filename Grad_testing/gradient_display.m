PLOT_GOAL = 1;
PLOT_OBSTACLE = 1;
STREAMLINES = 1;
VECTORS = 1;

STEP_SIZE = 20/10;

x = -10:STEP_SIZE:10;
y = -10:STEP_SIZE:10;
z = 0:STEP_SIZE:20;

[X, Y, Z] = meshgrid(x, y, z);

U = zeros(size(X));
V = zeros(size(X));
W = zeros(size(X));

for i = 1:(length(X)*length(Y)*length(Z))
    
    if (PLOT_GOAL == 1) && (PLOT_OBSTACLE == 1)
        grad = obstacle_grad([X(i); Y(i); Z(i)]) + score_grad([X(i); Y(i); Z(i)]);
    elseif PLOT_OBSTACLE == 1
        grad = obstacle_grad([X(i); Y(i); Z(i)]);
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

goal = [0; 5; 10];

obstacles = [
    -5,  2,  2, -5, -5; 
    -1, -1, -1, -1, -1; 
     9,  9,  2,  2, 9
];


grid on;
hold on;

plot3(goal(1), goal(2), goal(3), 'om')
fill3(obstacles(1, :), obstacles(2, :), obstacles(3, :), 'r')

if STREAMLINES == 1
    STREAM_STEPSIZE = 20/2;
    x1 = -10:STREAM_STEPSIZE:10;
    y1 = -10:STREAM_STEPSIZE:10;
    z1 = 0:STREAM_STEPSIZE:20;
        
    [X1, Y1, Z1] = meshgrid(x1, y1, z1);
    streamline(X, Y, Z, U, V, W, X1, Y1, Z1)
end

if VECTORS == 1
    colormap turbo
    quiverC3D(X, Y, Z, U, V, W, 'Colorbar', true)
end

view(-45,20)

xlabel('x')
ylabel('y')
zlabel('z')
legend('goal', 'obstacles', 'gradient')

