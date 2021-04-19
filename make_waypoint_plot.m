clear;
close all;

% Load model
load_system('AUV_waypoint');

% Simulate model
out = sim('AUV_waypoint');

% Parse out the log data
times = out.logsout{1}.Values.Time;

position = getElement(out.logsout, 'position').Values.Data(:, 1:3);
pos_N = position(:, 1);
pos_E = position(:, 2);
pos_D = position(:, 3);

trajectory = getElement(out.logsout, 'trajectory').Values.Data(1:3, :);
traj_N = trajectory(1, :);
traj_E = trajectory(2, :);
traj_D = trajectory(3, :);

waypoints = getElement(out.logsout, 'waypoints').Values.Data(:, :, 1);
waypoints_N = waypoints(1, :);
waypoints_E = waypoints(2, :);
waypoints_D = waypoints(3, :);

% New figure to plot on
fig = figure;

xlim([min([min(traj_E) min(pos_E)])-1 max([max(traj_E) max(pos_E)])+1])
ylim([min([min(traj_N) min(pos_N)])-1 max([max(traj_N) max(pos_N)])+1])
zlim([min([min(-traj_D) min(-pos_D)])-1 max([max(-traj_D) max(-pos_D)])+1])

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
plot3(pos_E, pos_N, -pos_D, 'color', light_blue, 'linewidth', 3)

% Plot AUV planned trajectory
plot3(traj_E, traj_N, -traj_D, 'color', yellow, 'linewidth', 2)

% Plot waypoints
scatter3(waypoints_E, waypoints_N, -waypoints_D, 60, 'magenta', 'linewidth', 2)
for i = 1:length(waypoints_E)-1
    text(waypoints_E(i), waypoints_N(i), -waypoints_D(i)+1, num2str(i-1), 'FontSize', 18)
end

% labels and titles
title('AUV waypoint follower')
xlabel('East axis (m)');
ylabel('North axis (m)');
zlabel('Depth (m)');
legend('AUV path', 'Planned trajectory', 'Waypoints')
ax = gca;
ax.FontSize = 16;

%     view(210, 35)
%     view(155, 15)
%     view(330, 5)
    view(40, 5)


