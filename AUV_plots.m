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

% Plot AUV path
plot3(pos_E, pos_N, -pos_D, 'linewidth', 2);

% Plot AUV planned trajectory
plot3(traj_E, traj_N, -traj_D, 'color', [0.9290 0.6940 0.1250], 'linewidth', 1);

% Plot wall
fill3(wall_E, wall_N, -wall_D, [0.6350 0.0780 0.1840])

% Plot goal
plot3(goal(2), goal(1), -goal(3), 'om', 'linewidth', 3)
text(goal(2)-0.3, goal(1)-0.3, -goal(3)-0.3, 'Goal', 'FontSize', 14)

% labels and titles
title('AUV pathfinding')
xlabel('East axis (m)');
ylabel('North axis (m)');
zlabel('Depth (m)');
legend('AUV path', 'Planned trajectory', 'Wall', 'Goal')
%     view(210, 35)
%     view(155, 15)
%     view(330, 5)
    view(358, 5)


