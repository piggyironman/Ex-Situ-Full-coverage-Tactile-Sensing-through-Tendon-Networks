syms theta1 theta2 theta3 theta4 theta5
theta = [theta1; theta2; theta3; theta4; theta5];

d_frame_end_4 = [-6.5; -30; 0];
d_frame_4_3 = [-1.5; -30; 0];
d_frame_3_2 = [0; -50; 1];
d_frame_2_1 = [0; 0; 0];
d_frame_1_0 = [0; 0; 0];

d_frame = {...
    d_frame_end_4,  ... end -> 4
    d_frame_4_3,    ... 4 -> 3
    d_frame_3_2,    ... 3 -> 2
    d_frame_2_1,    ... 2 -> 1
    d_frame_1_0     ... 1 -> 0
    };

ROT_end_4 = eye(3);
ROT_4_3 = my_rotation('z', theta4);
ROT_3_2 = my_rotation('y', pi/2) * my_rotation('z', theta3);
ROT_2_1 = my_rotation('y', -pi/2) * my_rotation('z', theta2);
ROT_1_0 = my_rotation('z', theta1);

TRANS_end_4 = my_transformation(ROT_end_4, d_frame_end_4);
TRANS_4_3 = my_transformation(ROT_4_3, d_frame_4_3);
TRANS_3_2 = my_transformation(ROT_3_2, d_frame_3_2);
TRANS_2_1 = my_transformation(ROT_2_1, d_frame_2_1);
TRANS_1_0 = my_transformation(ROT_1_0, d_frame_1_0);

TRANS_4_end = my_inverse_transformation(TRANS_end_4);
TRANS_3_4 = my_inverse_transformation(TRANS_4_3);
TRANS_2_3 = my_inverse_transformation(TRANS_3_2);
TRANS_1_2 = my_inverse_transformation(TRANS_2_1);
TRANS_0_1 = my_inverse_transformation(TRANS_1_0);

d_frame_end_4;
d_frame_end_3 = my_transform_point(TRANS_4_3, d_frame_end_4);
d_frame_end_2 = my_transform_point(TRANS_3_2, d_frame_end_3);
d_frame_end_1 = my_transform_point(TRANS_2_1, d_frame_end_2);
d_frame_end_0 = my_transform_point(TRANS_1_0, d_frame_end_1);

d_frame_4_end = [6.5; 30; 0];
d_frame_3_end = my_transform_point(TRANS_4_end*TRANS_3_4, [0; 0; 0]);
d_frame_2_end = my_transform_point(TRANS_4_end*TRANS_3_4*TRANS_2_3, [0; 0; 0]);
d_frame_1_end = my_transform_point(TRANS_4_end*TRANS_3_4*TRANS_2_3*TRANS_1_2, [0; 0; 0]);
d_frame_0_end = my_transform_point(TRANS_4_end*TRANS_3_4*TRANS_2_3*TRANS_1_2*TRANS_0_1, [0; 0; 0]);

d_hole_cable11_1_4 = [4.937; -4.937; 4.75];
d_hole_cable12_1_4 = [4.937; -4.937; -4.75];
d_hole_cable11_1_3 = [3.437; -25.063; 4.75];
d_hole_cable12_1_3 = [3.437; -25.063; -4.75];
d_hole_cable11_2_3 = [-1; -2.5; 7.5];
d_hole_cable12_2_3 = [-1; -2.5; -7.5];
d_hole_cable11_3_3 = [-1; 0; 7.5];
d_hole_cable12_3_3 = [-1; 0; -7.5];
d_hole_cable11_1_2 = [7.5; -50; 2];
d_hole_cable12_1_2 = [-7.5; -50; 2];
d_hole_cable11_2_2 = [7.5; -45.101; 2];
d_hole_cable12_2_2 = [-7.5; -45.101; 2];
d_hole_cable11_3_2 = [1; -7.5; -7.5];
d_hole_cable12_3_2 = [-1; -7.5; -7.5];

d_hole_cable21_1_3 = [6.35; -6.35; 5];
d_hole_cable22_1_3 = [6.35; -6.35; -5];
d_hole_cable21_1_2 = [5; -43.65; -5.35];
d_hole_cable22_1_2 = [-5; -43.65; -5.35];
d_hole_cable21_2_2 = [1; -9.5; -9.5];
d_hole_cable22_2_2 = [-1; -9.5; -9.5];

d_hole_cable31_1_2 = [5; -9.53; -9.53];
d_hole_cable32_1_2 = [-5; -9.53; -9.53];
d_hole_cable31_1_0 = [9.53; 9.53; 5];
d_hole_cable32_1_0 = [9.53; 9.53; -5];

syms Fx Fy Fz Px Py Pz taux tauy tauz
F_ex_end = [Fx; Fy; Fz];
P_ex_end = [Px; Py; Pz];
tau_ex_end = [taux; tauy; tauz];

tau_ex_4 = ROT_end_4*(tau_ex_end - cross(d_frame_4_end, F_ex_end));
tau_ex_3 = (ROT_4_3*ROT_end_4)*(tau_ex_end - cross(d_frame_3_end, F_ex_end));
tau_ex_2 = (ROT_3_2*ROT_4_3*ROT_end_4)*(tau_ex_end - cross(d_frame_2_end, F_ex_end));

syms T_cable11_s T_cable12_s T_cable21_s T_cable22_s T_cable31_s T_cable32_s
T_cable11_4 = T_cable11_s;
T_cable12_4 = T_cable12_s;

T_cable21_3 = T_cable21_s;
T_cable22_3 = T_cable22_s;

T_cable31_2 = T_cable31_s;
T_cable32_2 = T_cable32_s;

L_cable11_4 = my_transform_point(TRANS_3_4, d_hole_cable11_1_3) - d_hole_cable11_1_4;
L_cable12_4 = my_transform_point(TRANS_3_4, d_hole_cable12_1_3) - d_hole_cable12_1_4;

L_cable21_3 = my_transform_point(TRANS_2_3, d_hole_cable21_1_2) - d_hole_cable21_1_3;
L_cable22_3 = my_transform_point(TRANS_2_3, d_hole_cable22_1_2) - d_hole_cable22_1_3;

L_cable31_2 = my_transform_point(TRANS_1_2*TRANS_0_1, d_hole_cable31_1_0) - d_hole_cable31_1_2;
L_cable32_2 = my_transform_point(TRANS_1_2*TRANS_0_1, d_hole_cable32_1_0) - d_hole_cable32_1_2;

L_cable11_4_unit = L_cable11_4/norm(L_cable11_4);
L_cable12_4_unit = L_cable12_4/norm(L_cable12_4);

L_cable21_3_unit = L_cable21_3/norm(L_cable21_3);
L_cable22_3_unit = L_cable22_3/norm(L_cable22_3);

L_cable31_2_unit = L_cable31_2/norm(L_cable31_2);
L_cable32_2_unit = L_cable32_2/norm(L_cable32_2);

tau_cable_4 = cross(d_hole_cable11_1_4, (T_cable11_4 * L_cable11_4_unit))   ...
    + cross(d_hole_cable12_1_4, (T_cable12_4 * L_cable12_4_unit));
tau_cable_3 = cross(d_hole_cable21_1_3, (T_cable21_3 * L_cable21_3_unit))   ...
    + cross(d_hole_cable22_1_3, (T_cable22_3 * L_cable22_3_unit));   ...
    tau_cable_2 = cross(d_hole_cable31_1_2, (T_cable31_2 * L_cable31_2_unit))   ...
    + cross(d_hole_cable32_1_2, (T_cable32_2 * L_cable32_2_unit));

random_change = -0.1 + 0.2 * rand(1, 10);

variables = [theta1, theta2, theta3, theta4,...
    T_cable11_s, T_cable12_s, T_cable21_s, T_cable22_s, T_cable31_s, T_cable32_s];

[mod_11, mod_12, mod_21, mod_22, mod_31, mod_32] = deal(1, 1, 1, 1, 1, 1);

theta_cable11 = acos(dot(ROT_4_3 * L_cable11_4_unit, [0; 1; 0]));
theta_cable12 = theta_cable11;
theta_cable21 = acos(dot(ROT_3_2 * L_cable21_3_unit, [0; 1; 0]));
theta_cable22 = theta_cable21;
theta_cable31 = acos(dot(ROT_1_0 * ROT_2_1 * L_cable31_2_unit, [0; 1; 0]));
theta_cable32 = acos(dot(ROT_1_0 * ROT_2_1 * L_cable32_2_unit, [0; 1; 0]));

T_cable11_e = (T_cable11_s/exp(-0.02537*2*pi)/exp(-0.02537*theta3)/exp(-0.02537*theta1)/(1-0.1559*theta_cable11)/0.9016/mod_11);
T_cable12_e = (T_cable12_s/exp(-0.02537*2*pi)/exp(-0.02537*theta3)/exp(-0.02537*theta1)/(1-0.1559*theta_cable12)/0.9922/mod_12);
T_cable21_e = (T_cable21_s/exp(-0.02537*2*pi)/exp(-0.02537*theta1)/(1-0.1559*theta_cable21)/1.1978/mod_21);
T_cable22_e = (T_cable22_s/exp(-0.02537*2*pi)/exp(-0.02537*theta1)/(1-0.1559*theta_cable22)/0.9922/mod_22);
T_cable31_e = (T_cable31_s/exp(-0.02537*2*pi)/(1-0.1559*theta_cable31)/1.072/mod_31);
T_cable32_e = (T_cable32_s/exp(-0.02537*2*pi)/(1-0.1559*theta_cable32)/1.0028/mod_32);

tau_cable = [tau_cable_4(1); tau_cable_4(3);   ...
    tau_cable_3(1); tau_cable_3(3);   ...
    tau_cable_2(1); tau_cable_2(3)];   ...
    tau_ex = [tau_ex_4(1); tau_ex_4(3);
    tau_ex_3(1); tau_ex_3(3);
    tau_ex_2(1); tau_ex_2(3);];
values_given = [theta1, theta2, theta3, theta4,...
    T_cable11_e, T_cable12_e, T_cable21_e, T_cable22_e, T_cable31_e, T_cable32_e];

angle_tension_input;

P_F_ex_result_cal;
