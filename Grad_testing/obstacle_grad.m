function gradient = obstacle_grad(position)

    S = 2;      % Scaling factor which influences gradient attenuation
    Limit = 5;  % Set values to zero beyond this range
    
    obstacles = [
        -5,  2,  2, -5, -5; 
        -3, -3, -3, -3, -3; 
         9,  9,  2,  2,  9
    ];

    % determine closest point on obstacle to position    
    if position(1) < obstacles(1, 4) && position(3) < obstacles(3, 4)
        % postion is to the bottom left of obstacle
        d1 = obstacles(:, 4) - position;

    elseif position(1) < obstacles(1, 1) && position(3) > obstacles(3, 1)
        % postion is to the top left of obstacle
        d1 = obstacles(:, 1) - position;

    elseif position(1) > obstacles(1, 3) && position(3) < obstacles(3, 3)
        % postion is to the bottom right of obstacle
        d1 = obstacles(:, 3) - position;

    elseif position(1) > obstacles(1, 2) && position(3) > obstacles(3, 2)
        % postion is to the top right of obstacle
        d1 = obstacles(:, 2) - position;

    elseif position(1) < obstacles(1, 1)
        % postion is to the left of obstacle
        d1 = [obstacles(1,1) - position(1);
              obstacles(2,1) - position(2);
              0];
    elseif position(1) > obstacles(1, 2)
        % postion is to the right of obstacle
        d1 = [obstacles(1, 2) - position(1);
              obstacles(2, 2) - position(2);
              0];
    elseif position(3) < obstacles(3, 3)
        % postion is below obsticle
        d1 = [0;
              obstacles(2, 3) - position(2);
              obstacles(3, 3) - position(3)];
    elseif position(3) > obstacles(3, 2)
        % postion is above obstacle
        d1 = [0;
              obstacles(2, 2) - position(2);
              obstacles(3, 2) - position(3)];
    else
        % position overlaps on y axis
        d1 = [0;
              obstacles(2, 1) - position(2);
              0];
    end
    
    if norm(d1) < Limit 
        gradient = -S/(S+norm(d1)) * d1/norm(d1);
    else
        gradient = [0;0;0];
    end
end

