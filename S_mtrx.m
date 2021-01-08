function S = S_mtrx(alpha)

S = [0,        -alpha(3), alpha(2);
    alpha(3),  0,         -alpha(1);
    -alpha(2), alpha(1),  0;
    ];
end