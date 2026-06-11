F_ex_end_test_points = nan(3, 6, 3);
P_ex_end_test_points = nan(3, 6, 3);
theta_ex_end_test_points = nan(4, 6, 3);

P_ex_end_test_points_raw1 = nan(3, 6, 3);
P_ex_end_test_points_raw2 = nan(3, 6, 3);

P_ex_end_test_points_raw1(:, 1:6, 1) = [-108.87, -105.89, -102.09,  -97.9, -93.51, -89.04;
    -4.03,   -7.41,   -9.81, -11.45, -12.47, -12.95;
    0,       0,       0,      0,      0,      0];
P_ex_end_test_points_raw1(:, 1:6, 2) = [-107.66, -105.02, -101.48, -97.49, -93.28, -88.97;
    -3.34,   -6.34,   -8.57, -10.12,  -11.1, -11.56;
    4.5,     4.5,     4.5,    4.5,    4.5,    4.5];
P_ex_end_test_points_raw1(:, 2:5, 3) = [-102.6, -99.79, -96.38, -92.65;
    -3.37,  -5.13,  -6.46,  -7.32;
    7.5,    7.5,    7.5,   7.5];
P_ex_end_test_points_raw2(:, 1:6, 1) = [-103.97, -102.26, -99.66, -96.52, -92.71, -88.78;
    -1.21,   -2.96,  -4.88,  -6.93,  -7.69,  -7.83;
    0,       0,      0,      0,      0,      0];
P_ex_end_test_points_raw2(:, 1:6, 2) = [-105.12, -103.63, -100.72, -96.96, -92.93, -88.89;
    -1.87,   -4.63,   -7.03,  -8.38,  -8.99, -10.08;
    2.5,       3,    3.33,   3.26,   3.05,   3.49];
P_ex_end_test_points_raw2(:, 2:5, 3) = [ -98.64, -97.14, -94.44, -91.63;
    1.5,   0.26,  -0.09,  -1.18;
    -9.41,  -8.69, -10.42,  -9.27];

theta_ex_end_test_points(:, 1, :) = (repmat([0; 0; 60*1/4; 60-60*1/4], 1, 1, 3));
theta_ex_end_test_points(:, 1, 1) = ([0; 0; 60*2/4; 60-60*2/4]);
theta_ex_end_test_points(:, 2, :) = (repmat([0; 0; 39.16*3/4; 39.16-39.16*3/4], 1, 1, 3));
theta_ex_end_test_points(:, 3, :) = (repmat([0; 0; 26.16*2/3; 26.16-26.16*2/3], 1, 1, 3));
theta_ex_end_test_points(:, 3, 3) = ([0; 0; 26.16*1.5/4; 26.16-26.16*1.5/4]);
theta_ex_end_test_points(:, 4, :) = (repmat([0; 0; 16.91/2; 16.91/2], 1, 1, 3));
theta_ex_end_test_points(:, 5, :) = (repmat([0; 0; 9.47/2; 9.47/2], 1, 1, 3));
theta_ex_end_test_points(:, 6, :) = (repmat([0; 0; 2.88*3.5/4; 2.88*3.5/4], 1, 1, 3));
theta_ex_end_test_points(:, 6, 1) = ([0; 0; 2.88*2.5/4; 2.88*2.5/4]);

P_ex_end_test_points(1, :, :) = -P_ex_end_test_points_raw1(2, :, :);
P_ex_end_test_points(2, :, :) = P_ex_end_test_points_raw1(1, :, :) + 110;
P_ex_end_test_points(3, :, :) = P_ex_end_test_points_raw1(3, :, :);

F_ex_end_test_points_raw = P_ex_end_test_points_raw2 - P_ex_end_test_points_raw1;
F_ex_end_test_points_raw_normalized = F_ex_end_test_points_raw ./ sqrt(sum(F_ex_end_test_points_raw.^2, 1));
F_ex_end_test_points(1, :, :) = -F_ex_end_test_points_raw_normalized(2, :, :);
F_ex_end_test_points(2, :, :) = F_ex_end_test_points_raw_normalized(1, :, :);
F_ex_end_test_points(3, :, :) = F_ex_end_test_points_raw_normalized(3, :, :);

P_ex_end_test_points2 = P_ex_end_test_points + F_ex_end_test_points;

if i == 1

    angle_tension_input_test = nan(10, 6, 3);
    angle_tension_input_test(1:4, 1, :) = theta_ex_end_test_points(:, 1, :);
    angle_tension_input_test(1:4, 2, :) = theta_ex_end_test_points(:, 2, :);
    angle_tension_input_test(1:4, 3, :) = theta_ex_end_test_points(:, 3, :);
    angle_tension_input_test(1:4, 4, :) = theta_ex_end_test_points(:, 4, :);
    angle_tension_input_test(1:4, 5, :) = theta_ex_end_test_points(:, 5, :);
    angle_tension_input_test(1:4, 6, :) = theta_ex_end_test_points(:, 6, :);

    tool_for_force_tobe_applied;
    i = 1;
    angle_tension_input_test_disturbed_set = nan(10, 6, 3, 20);
    saved_test_point_force;
end

rng('shuffle');

random_noise = -0.02 + 0.04 * rand(6, 6, 3);

nan_mask = isnan(angle_tension_input_test(5:10,:,:));

angle_tension_input_test_disturbed = angle_tension_input_test;
angle_tension_input_test_disturbed(5:10,:,:) = angle_tension_input_test(5:10,:,:) + random_noise;
angle_tension_input_test_disturbed_set(:,:,:,i) = angle_tension_input_test_disturbed;
