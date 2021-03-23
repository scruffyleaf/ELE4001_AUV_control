clear;
close all;

% Load model
load_system('AUV_main');

% Simulate model
out = sim('AUV_main');

% Parse out the log data
sampleTimes = out.logsout{1}.Values.Time;

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

% labels and titles
title('AUV pathfinding')
xlabel('North axis (m)');
ylabel('East axis (m)');
zlabel('Depth (m)');

grid on
hold on
ax = gca;

% Create a video file to save the animation to
v = VideoWriter('AUV_330.m4v', 'MPEG-4');
v.Quality = 95;
open(v);

% Plot frames individually and save animation
movie_len = floor(sampleTimes(end));
samples_no = length(sampleTimes);
animation(movie_len) = struct('cdata',[],'colormap',[]);

for t = 1:movie_len
    
    i = 1;
    while t > sampleTimes(i)
        i = i + 1;
    end
    
    cla(ax)
    
    % Plot AUV path
    plot3(pos_E(1:i), pos_N(1:i), -pos_D(1:i), 'b-', 'linewidth', 2)

    % Plot AUV desired trajectory
    plot3(traj_E(1:i), traj_N(1:i), -traj_D(1:i), 'color', [0.9290 0.6940 0.1250], 'linewidth', 1);

    % Plot wall
    fill3(wall_E, wall_N, -wall_D, [0.6350 0.0780 0.1840])

    % Plot goal
    plot3(goal(2), goal(1), -goal(3), 'om', 'linewidth', 3)
    text(goal(2)+0.3, goal(1)-0.3, -goal(3)-0.3, 'Goal', 'FontSize', 14)
    
    legend('AUV path', 'Planned trajectory', 'Wall', 'Goal')
%     view(155, 15)
%     view(210, 35)
    view(330, 5)
%     view(358, 5)

    drawnow
    frame = getframe(fig);
    writeVideo(v,frame);
    animation(t) = frame;
end

% Hold final frame for a little longer
for j = 1:ceil(movie_len/20)
    frame = getframe(fig);
    writeVideo(v,frame);
end

close(v);

% fig.Visible = 'on';
% movie(animation);

