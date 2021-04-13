function J = Jacobian(a, b, c)
% Calculates Euler angle rotations
%
% a, b, c are angles of rotation about x, y and z axiz respectively

ca = cos(a);
cb = cos(b);
cc = cos(c);
sa = sin(a);
sb = sin(b);
sc = sin(c);

J_11 = [
    cc*cb  cc*sb*sa-sc*ca  cc*sb*ca+sc*sa;
    sc*cb  sc*sb*sa+cc*ca  sc*sb*ca-cc*sa;
    -sb    cb*sa           cb*ca;
];
J_22 = [
    1  sb*sa/ca  cb*sa/ca;
    0  cb        -sb;
    0  sb/ca     cb/ca;
];


J = [
    J_11      zeros(3);
    zeros(3)  J_22;
];

