clear
close all

light_blue = [0,161,225]/255;
dark_blue = [0,77,126]/255;
green = [102,153,51]/255;
orange = [241,137,3]/255;
yellow = [255,204,0]/255;
dark_red = [143,14,32]/255;
purple = [172,0,77]/255;

speed = 1;
wps = [0 3 5; 0 4 1];   % waypoints A, B, C
tps = [0 5 9.5];
v_B = [5 1]/norm([5 1]);
vps = [0 v_B(1) 0; 0 v_B(2) 0];

t_sample = 0:0.01:10;

[q, qd, qdd, pp] = cubicpolytraj(wps, tps, t_sample, 'VelocityBoundaryCondition', vps);

figure
xlim([-1 6])
ylim([-1 5])
hold on

scatter(wps(1,:), wps(2,:), 60, 'om', 'linewidth', 2.5)
plot(q(1,:), q(2,:), '-', 'color', dark_red, 'linewidth', 2.5)
quiver(wps(1,2)-v_B(1), wps(2,2)-v_B(2), 2.5*v_B(1), 2.5*v_B(2), 'color', light_blue, 'linewidth', 2.5)
text(wps(1,1)+0.1, wps(2,1), 'A', 'FontSize', 18)
text(wps(1,2), wps(2,2)-0.2, 'B', 'FontSize', 18)
text(wps(1,3)+0.1, wps(2,3), 'C', 'FontSize', 18)
xlabel('X')
ylabel('Y')
legend('Waypoints', 'Trajectory', 'Velocity at B')

ax = gca;
ax.FontSize = 16;
