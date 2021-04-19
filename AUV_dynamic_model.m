function [M, C, D, g] = AUV_dynamic_model(v)
    % For calculating the modeling terms of the AUV
    % AUV is modeled as a cylinder with CG = CB in the center

    %
    % AUV constants
    r_g = [0, 0, 0]; % Location of CG with respect to CO
    m = 12.55;  % mass in kg
    r = 0.075;  % radius in m
    l = 0.71;   % length in m
    rho = 1000; % density of water


    %
    % Inertial tensors
    I_xx = m*(r^2)/2;
    I_yy = m*(3*r^2 + l^2)/12;
    I_zz = m*(3*r^2 + l^2)/12;
    I_g = [
        I_xx, 0,    0;
        0,    I_yy, 0;
        0,    0,    I_zz
    ];

    % Mass matrix
    M_RB = [
        m*eye(3),       -m*S_mtrx(r_g);
        m*S_mtrx(r_g),  I_g
    ];

    % Added mass terms Fossen 1994 p.37,38
    X_u = 0.1*m;
    Y_v = m;
    Z_w = m;
    K_p = 0;
    M_q = (0.1*m*r^2 + pi*rho*r^2*l^3)/12;
    N_r = (0.1*m*r^2 + pi*rho*r^2*l^3)/12;

    M_A = diag([X_u, Y_v, Z_w, K_p, M_q, N_r]);
    M = M_RB + M_A;

    
    % 
    % Coriolis and centripetal matrix
    v_2 = [v(4); v(5); v(6)];
    C_RB = [
        m*S_mtrx(v_2),             -m*S_mtrx(v_2)*S_mtrx(r_g);
        m*S_mtrx(r_g)*S_mtrx(v_2), -S_mtrx(I_g*v_2)
    ];

    % Fossen 1994 p.37
    C_A11 = zeros(3);
    C_A12 = -S_mtrx([X_u*v(1), Y_v*v(2), Z_w*v(3)]);
    C_A21 = C_A12;
    C_A22 = -S_mtrx([K_p*v(4), M_q*v(5), N_r*v(6)]);
    C_A = [
        C_A11, C_A12;
        C_A21, C_A22
    ];

    C = C_RB;
    

    %
    % Dampening matrix
    A_yz = pi*r^2; % frontal area of each plane
    A_zx = 2*r*l;
    A_xy = 2*r*l;
    
    C_d = [0.25; 0.60; 0.60; 0.05; 0.60; 0.60]; % Coefficents of drag
    
    D = diag(0.5*rho*C_d.*[
        A_yz*abs(v(1)); 
        A_zx*abs(v(2)); 
        A_xy*abs(v(3)); 
        A_yz*abs(v(4));
        A_xy*abs(v(5));
        A_zx*abs(v(6));
    ]);
                  
                  
    %
    % Gravitational and buoyancy forces
    g = zeros(6, 1); % assume neutral buoyancy
end