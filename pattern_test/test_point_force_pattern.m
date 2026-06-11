pattern_test = 's';
switch pattern_test
    case 'o'
        pattern_o;
        num_points_test = num_points_o;

        P_ex_end_test_points = pattern_points_o;
    case 's'
        pattern_s;
        num_points_test = num_points_s;

        P_ex_end_test_points = pattern_points_s;
    case 'z'
        pattern_z;
        num_points_test = num_points_z;

        P_ex_end_test_points = pattern_points_z;
    case 'square'
        pattern_square;
        num_points_test = num_points_square;

        P_ex_end_test_points = pattern_points_square;
    otherwise
        num_points_test = NaN;
end

F_ex_end_test_points = repmat([-1; 0; 0], 1, num_points_test);
P_ex_end_test_points2 = P_ex_end_test_points - F_ex_end_test_points;

theta_ex_end_test_points(:, :) = (repmat([60*1/4; 0; 60*1/4; 60*1/4], 1, num_points_test)) ;

if i == 1
    angle_tension_input_test = nan(10, num_points_test);
    angle_tension_input_test(1:4, :) = theta_ex_end_test_points;

    tool_for_force_tobe_applied_pattern;
    i = 1;
elseif i == 2
    tool_for_force_tobe_applied_pattern;
    i = 2;
end

rng('shuffle');

random_noise = -0.02 + 0.04 * rand(6, num_points_test);

angle_tension_input_test_disturbed = angle_tension_input_test;
angle_tension_input_test_disturbed(5:10,:) = angle_tension_input_test(5:10,:) + random_noise;
