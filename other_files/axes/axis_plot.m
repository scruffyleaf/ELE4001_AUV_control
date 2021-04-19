clear
close all

angles = 0:pi/100:2*pi;
sinang = 0.2*sin(angles);
cosang = 0.2*cos(angles);
offset = angles*0 + 0.6;

X = [0; 0; 0];
Y = [0; 0; 0];
Z = [0; 0; 0];
U = [1; 0; 0];
V = [0; 1; 0];
W = [0; 0; 1];

grey = '#9B9B9B';
red = '#AC004D';

fig = figure;
xlim([-0.25, 1])
ylim([-0.25, 1])
zlim([-0.25, 1])
view(116, 38)

grid on;
hold on;

quiver3(X, Y, Z, U, V, W, 'color', red, 'LineWidth', 2.5)
xlabel('x')
ylabel('y')
zlabel('z')
title('Trajectory Frame')

ax = gca;
ax.FontSize = 20; 
ax.XTick = 0:0.5:1;
ax.YTick = 0:0.5:1;
ax.ZTick = 0:0.5:1;

plot3(offset, sinang, cosang, 'color', grey, 'LineWidth', 1);
plot3(cosang, offset, sinang, 'color', grey, 'LineWidth', 1);
plot3(sinang, cosang, offset, 'color', grey, 'LineWidth', 1);

plot3(offset(30), sinang(30), cosang(30), '>', 'color', grey, 'LineWidth', 2);
plot3(cosang(30), offset(30), sinang(30), '>', 'color', grey, 'LineWidth', 2);
plot3(sinang(30), cosang(30), offset(30), '>', 'color', grey, 'LineWidth', 2);

