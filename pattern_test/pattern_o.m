center_o = [0, 12, 0];
radius_o = 6;
num_points_o = 100;

theta_o = linspace(0, 2*pi, num_points_o);
pattern_points_o(2, :) = center_o(2) + radius_o * cos(theta_o);
pattern_points_o(3, :) = center_o(3) + radius_o * sin(theta_o);
pattern_points_o(1, :) = zeros(1, num_points_o);
