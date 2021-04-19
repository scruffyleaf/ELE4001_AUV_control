clear
close all

angles = 0:pi/100:2*pi;
sinang = 0.2*sin(angles);
cosang = 0.2*cos(angles);
offset = angles*0 + 0.6;

X_1 = [0; 0; 0];
Y_1 = [0; 0; 0];
Z_1 = [0; 0; 0];
U_1 = [1; 0; 0];
V_1 = [0; 0; 0];
W_1 = [0; 0; 1];

X_2 = [0; 0; 0];
Y_2 = [0; 0; 0];
Z_2 = [0; 0; 0];
U_2 = [0; 0; 0];
V_2 = [0; 1; 0];
W_2 = [0; 0; 0];

grey = '#9B9B9B';
red = '#AC004D';

fig = figure;
xlim([-0.25, 1])
ylim([-0.25, 1])
zlim([-0.25, 1])
view(116, 38)

grid on;
hold on;

xlabel('x')
ylabel('y')
zlabel('z')
title('AUV DoF')

ax = gca;
ax.FontSize = 20; 
ax.XTick = 0:0.5:1;
ax.YTick = 0:0.5:1;
ax.ZTick = 0:0.5:1;

quiver3(X_1, Y_1, Z_1, U_1, V_1, W_1, 'color', red, 'LineWidth', 2.5)
quiver3(X_2, Y_2, Z_2, U_2, V_2, W_2, 'color', grey, 'LineWidth', 1)

plot3(offset, sinang, cosang, 'color', red, 'LineWidth', 2);
plot3(cosang, offset, sinang, 'color', grey, 'LineWidth', 1);
plot3(sinang, cosang, offset, 'color', red, 'LineWidth', 2);

plot3(offset(30), sinang(30), cosang(30), '>', 'color', red, 'LineWidth', 2);
plot3(cosang(30), offset(30), sinang(30), '>', 'color', grey, 'LineWidth', 2);
plot3(sinang(30), cosang(30), offset(30), '>', 'color', red, 'LineWidth', 2);

