load mean_ERR

figure
set(gca, 'fontsize', 18, 'fontname', 'Times New Roman')
hold on

plot(0:180, mean_ERR(1,:), 'b--', 'linewidth', 3)
plot(0:180, mean_ERR(2,:), 'r-.', 'linewidth', 3)
plot(0:180, mean_ERR(3,:), 'color', [0.6 0.07 1.0], 'linewidth', 3)

legend('distance compensation = T', 'distance compensation = 3T/4', 'distance compensation = T/2')

xlabel('Mean of angles created at the location of the lost car')
ylabel('Mean error')