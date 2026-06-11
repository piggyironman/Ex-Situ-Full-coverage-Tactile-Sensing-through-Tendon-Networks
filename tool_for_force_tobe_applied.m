config;

for i = 1:6
    for j = 1:3
        [theta1_given, theta2_given, theta3_given, theta4_given] = deal(angle_tension_input_test(1, i, j),...
            angle_tension_input_test(2, i, j),...
            angle_tension_input_test(3, i, j), ...
            angle_tension_input_test(4, i, j));
        if isnan(P_ex_end_test_points(1, i, j))
            continue
        end

        F_ex_end_applied = 0.25 * F_ex_end_test_points(:, i, j);
        P_ex_end_applied = P_ex_end_test_points(:, i, j);

        tau_ex_end_applied = cross(P_ex_end_applied, F_ex_end_applied);

        tau_ex_applied_temp = subs(tau_ex, [[theta1, theta2, theta3, theta4], F_ex_end.', tau_ex_end.'], [[theta1_given, theta2_given, theta3_given, theta4_given], F_ex_end_applied.', tau_ex_end_applied.']);
        tau_cable_tosolve_temp = subs(tau_cable, [theta1, theta2, theta3, theta4], [theta1_given, theta2_given, theta3_given, theta4_given]);

        eqns_system_tosolve = (tau_ex_applied_temp + tau_cable_tosolve_temp) == 0;

        vars_tosolve = [T_cable11_s, T_cable12_s, T_cable21_s, T_cable22_s, T_cable31_s, T_cable32_s];

        sol_tosolve = solve(eqns_system_tosolve, vars_tosolve);

        T_cable_situ = [double(sol_tosolve.T_cable11_s); double(sol_tosolve.T_cable12_s); double(sol_tosolve.T_cable21_s); double(sol_tosolve.T_cable22_s); double(sol_tosolve.T_cable31_s); double(sol_tosolve.T_cable32_s)];
        T_cable_sensed = [(T_cable_situ(1)*exp(-0.02537*2*pi)*exp(-0.02537*theta3_given)*exp(-0.02537*theta1_given)*(1-0.1559*theta_cable11)*0.9016*mod_11);...
            (T_cable_situ(2)*exp(-0.02537*2*pi)*exp(-0.02537*theta3_given)*exp(-0.02537*theta1_given)*(1-0.1559*theta_cable12)*0.9922*mod_12);...
            (T_cable_situ(3)*exp(-0.02537*2*pi)*exp(-0.02537*theta1_given)*(1-0.1559*theta_cable21)*1.1978*mod_21);...
            (T_cable_situ(4)*exp(-0.02537*2*pi)*exp(-0.02537*theta1_given)*(1-0.1559*theta_cable22)*0.9922*mod_22);...
            (T_cable_situ(5)*exp(-0.02537*2*pi)*(1-0.1559*theta_cable31)*1.072*mod_31);...
            (T_cable_situ(6)*exp(-0.02537*2*pi)*(1-0.1559*theta_cable32)*1.0028*mod_32);...
            ];
        T_cable_sensed = double(subs(T_cable_sensed, [theta1, theta2, theta3, theta4], [theta1_given, theta2_given, theta3_given, theta4_given]));

        T_cable_situ = transpose(T_cable_situ);
        T_cable_sensed = transpose(T_cable_sensed);

        angle_tension_input_test(5:10, i, j) = T_cable_sensed;
    end
end
