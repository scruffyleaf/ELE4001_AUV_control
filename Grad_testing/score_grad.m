function gradient = score_grad(position)
    S = 10;
    goal = [0; 5; 10];
    d0 = goal - position;

    gradient = (1 - S/(S+norm(d0))) * d0/norm(d0);
end

