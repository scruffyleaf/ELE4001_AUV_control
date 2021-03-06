% Test function for gradient following

N = 1000;
inital_path = [
    0, 1, 2, 3, 3, 3, 3, 3, 3, 3;
    0, 0, 0, 0, 1, 2, 3, 3, 3, 3;
    0, 0, 0, 0, 0, 0, 0, 1, 2, 3;
];
path = [inital_path, zeros(3, N)];
grad = zeros(1, N);

max_grad = [0; 1];                      % value; pos index
min_grad = [1; 1];                      % value; pos index

s0 = 0;                                 % current score
s1 = 0;                                 % previous score
v0 = [0;0;0];                           % current vector
v1 = [0;0;0];                           % previous vector

goal_score = 0.95;
i = 1;
while 1
    i = i + 1;
    position = path(1:3, i);
    grad(i) = gradient(position);
    
    % update gradient
    if grad(i) > max_grad(1)
        max_grad = [grad(i); i];
    elseif grad(i) < min_grad(1)
        min_grad = [grad(i); i];
    end
    
    % choose a path direction
    p0 = path(1:3, i);                              % Current point
    p1 = path(1:3, i-1);                            % Previous point
    previous_vector = current_vector;
    current_vector = (p0 - p1) / norm(p0-p1);
    
    % end if the simulation is not converging
    if i > N-2
        disp('Could not converge')
        break
    end
    
    % end if path has reached the goal
    if grad(i) > goal_score
        disp('Goal reached')
        break
    end
end

