function S = score(position)
    gradient_minimum = [-5; -5; 10];  
    distance = norm((gradient_minimum - position));
    S = 1/(distance + 1);
end