values_given_temp = subs(values_given, ...
    [theta1, theta2, theta3, theta4,...
    T_cable11_s, T_cable12_s, T_cable21_s, T_cable22_s, T_cable31_s, T_cable32_s], ...
    [theta1_given, theta2_given, theta3_given, theta4_given, ...
    T_cable11_s_given, T_cable12_s_given, T_cable21_s_given, T_cable22_s_given, T_cable31_s_given, T_cable32_s_given]);
tau_cable_temp = subs(tau_cable, variables, values_given_temp);
tau_ex_temp = subs(tau_ex, variables, values_given_temp);

eqns_system_init = (tau_cable_temp + tau_ex_temp);
eqns_system_final = subs(eqns_system_init, [taux, tauy, tauz], [Fz*Py - Fy*Pz, Fx*Pz - Fz*Px, Fy*Px - Fx*Py]);

F_eqns_system_final = matlabFunction(eqns_system_final, 'Vars', {[Px; Py; Pz; Fx; Fy; Fz]});

x0 = [0; 0; 0; 0; 0; 0];
options = optimoptions('lsqnonlin',...
    'Display','iter', ...
    'MaxIterations', 2000, ...
    'MaxFunctionEvaluations', 5000, ...
    'FunctionTolerance', 1e-10, ...
    'StepTolerance', 1e-10);

w_plane = 1e2;

F_constrained = @(x) [
    F_eqns_system_final(x);
    w_plane * x(1)
    ];

[sol, resnorm] = lsqnonlin(F_constrained, x0, [], [], options);

F_ex_result = sol(4:6)
P_ex_result = sol(1:3)
