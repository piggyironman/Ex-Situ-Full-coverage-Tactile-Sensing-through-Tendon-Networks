clear; clc;

config;

color_set_for_points;
sensing_area;
hold on;

for i = 1:2
    test_point_force_pattern;
    for j = 1:num_points_test

        if i == 1
            [theta1_given, theta2_given, theta3_given, theta4_given, ...
                T_cable11_s_given, T_cable12_s_given, T_cable21_s_given, T_cable22_s_given, T_cable31_s_given, T_cable32_s_given]   ...
                = deal(...
                angle_tension_input_test(1,j), angle_tension_input_test(2,j), ...
                angle_tension_input_test(3,j), angle_tension_input_test(4,j), ...
                angle_tension_input_test(5,j), angle_tension_input_test(6,j), ...
                angle_tension_input_test(7,j), angle_tension_input_test(8,j), ...
                angle_tension_input_test(9,j), angle_tension_input_test(10,j));
            if isnan(angle_tension_input_test(5, j))
                continue
            end
        else
            [theta1_given, theta2_given, theta3_given, theta4_given, ...
                T_cable11_s_given, T_cable12_s_given, T_cable21_s_given, T_cable22_s_given, T_cable31_s_given, T_cable32_s_given]   ...
                = deal(...
                angle_tension_input_test_disturbed(1,j), angle_tension_input_test_disturbed(2,j), ...
                angle_tension_input_test_disturbed(3,j), angle_tension_input_test_disturbed(4,j), ...
                angle_tension_input_test_disturbed(5,j), angle_tension_input_test_disturbed(6,j), ...
                angle_tension_input_test_disturbed(7,j), angle_tension_input_test_disturbed(8,j), ...
                angle_tension_input_test_disturbed(9,j), angle_tension_input_test_disturbed(10,j));
            if isnan(angle_tension_input_test(5, j))
                continue
            end
        end
        P_F_ex_result_cal;

        F = F_ex_result;
        r0 = P_ex_result;

        r = 8;
        a = 13; b = 23;

        lambda_x_min = (-15 - r0(1)) / F(1);
        lambda_x_max = (15 - r0(1)) / F(1);
        lambda_y_min = (-25 - r0(2)) / F(2);
        lambda_y_max = (25 - r0(2)) / F(2);
        lambda_z_min = (-10 - r0(3)) / F(3);
        lambda_z_max = (10 - r0(3)) / F(3);

        lambda_min_all = [];
        lambda_max_all = [];

        if F(1) ~= 0
            lambda_min_all(end+1) = min(lambda_x_min, lambda_x_max);
            lambda_max_all(end+1) = max(lambda_x_min, lambda_x_max);
        end
        if F(2) ~= 0
            lambda_min_all(end+1) = min(lambda_y_min, lambda_y_max);
            lambda_max_all(end+1) = max(lambda_y_min, lambda_y_max);
        end
        if F(3) ~= 0
            lambda_min_all(end+1) = min(lambda_z_min, lambda_z_max);
            lambda_max_all(end+1) = max(lambda_z_min, lambda_z_max);
        end

        lambda_lb = max(lambda_min_all);
        lambda_ub = min(lambda_max_all);

        x0 = [pi/4, 0, 0];

        lb = [0, -pi, lambda_lb];
        ub = [2*pi, pi, lambda_ub];

        opts = optimoptions('lsqnonlin', 'Display', 'iter', ...
            'TolFun', 1e-10, 'TolX', 1e-10);

        x_sol = lsqnonlin(@(x) surface_point(x, r0, F, r, a, b), x0, lb, ub, opts);
        intersection = r0 + x_sol(3)*F;
        disp('Intersection coordinates:');
        disp(intersection);
        disp(j);

        disp('Intersection coordinates:');
        disp(intersection);

        intersection_output_set(:, j, i) = intersection;
        F_ex_result_output_set(:, j, i) = F_ex_result;

        if i ~= 1
            scatter3(intersection(1), intersection(2), intersection(3), ...
                100, ...
                ...color_set((k - 1) * 6 + j,:), ...
                'o', ...
                'LineWidth', 1.5);
        else
            scatter3(intersection(1), intersection(2), intersection(3), ...
                10, ...
                ...color_set((k - 1) * 6 + j,:), ...
                'filled', ...
                'LineWidth', 1.5);
        end

        lambda_vals = linspace(-60, 0, 100);
        line_pts = r0 + F * lambda_vals;
        plot3(line_pts(1,:), line_pts(2,:), line_pts(3,:), ...
            'r-', 'LineWidth', 2, 'DisplayName', 'Force line of action');
    end
end

axis equal;
grid on;
title('Distribution of force lines, intersections, and test points');
hold off;

function cost = objective(x, r0, F, r, a, b)
    f = surface_point(x, r0, F, r, a, b);
    cost = sum(f.^2);
end

function [c, ceq] = nonlinear_constraint(x, r0, F)
    point = r0 + x(3)*F;
    c = -point(3) - 5;
    ceq = [];
end
