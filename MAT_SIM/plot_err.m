% load mean_ERR
load mean_ERR_M_12-16_10_6

figure
set(gca, 'fontsize', 18, 'fontname', 'Times New Roman')
hold on

% plot(0:180, mean_ERR(1,:), 'b--', 'linewidth', 3)
% plot(0:180, mean_ERR(2,:), 'r-.', 'linewidth', 3)
% plot(0:180, mean_ERR(3,:), 'color', [0.6 0.07 1.0], 'linewidth', 3)

plot(0:0.01:1, mean_ERR_M(1,1:101), 'b--', 'linewidth', 3)
plot(0:0.01:1, mean_ERR_M(2,1:101), 'r-.', 'linewidth', 3)
plot(0:0.01:1, mean_ERR_M(3,1:101), 'color', [0.6 0.07 1.0], 'linewidth', 3)

legend('distance compensation = 90%', 'distance compensation = 70%', 'distance compensation = 50%')

% xlabel('Mean of angles created at the location of the lost car')
xlabel('Distance of the median from the location of the lost car')
ylabel('Mean error')