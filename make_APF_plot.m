clear;
close all;

% Load model
load_system('AUV_APF');

% Simulate model
out = sim('AUV_APF');

% Parse out the log data
times = out.logsout{1}.Values.Time;

position = getElement(out.logsout, 'position').Values.Data(:, 1:3);
pos_N = position(:, 1);
pos_E = position(:, 2);
pos_D = position(:, 3);

trajectory = getElement(out.logsout, 'trajectory').Values.Data(:, 1:3);
traj_N = trajectory(:, 1);
traj_E = trajectory(:, 2);
traj_D = trajectory(:, 3);

wall = getElement(out.logsout, 'wall').Values.Data(:, :, 1);
wall_N = wall(1, :);
wall_E = wall(2, :);
wall_D = wall(3, :);

goal = getElement(out.logsout, 'goal').Values.Data(3, :);

% New figure to plot on
fig = figure;
xlim([min(pos_E(:)-1) max(pos_E(:)+1)])
ylim([min(pos_N(:)-1) max(pos_N(:)+1)])
zlim([min(-pos_D(:)-1) max(-pos_D(:)+1)])

grid on
hold on

% define colours
light_blue = [0,161,225]/255;
dark_blue = [0,77,126]/255;
green = [102,153,51]/255;
orange = [241,137,3]/255;
yellow = [255,204,0]/255;
dark_red = [143,14,32]/255;
purple = [172,0,77]/255;

% Plot AUV path
plot3(pos_E, pos_N, -pos_D, 'color', light_blue, 'linewidth', 2)

% Plot AUV planned trajectory
plot3(traj_E, traj_N, -traj_D, 'color', yellow, 'linewidth', 1.5)

% Plot wall
fill3(wall_E, wall_N, -wall_D, dark_red)

% Plot goal
scatter3(goal(2), goal(1), -goal(3), 60, 'magenta', 'linewidth', 2)
text(goal(2)+4, goal(1)-1, -goal(3), 'Goal', 'FontSize', 18)

% labels and titles
title('APF guidance')
xlabel('East axis (m)');
ylabel('North axis (m)');
zlabel('Depth (m)');
legend('AUV path', 'Planned trajectory', 'Wall', 'Goal')
ax = gca;
ax.FontSize = 16;
    view(150, 20)


