amplitude = 4;
frequency = 1/(4*pi);
y_start = 110 - 34*pi;
y_end = 110 - 29*pi;
num_points_s = 100;

y_sine = linspace(y_start, y_end, num_points_s);
z_sine = -amplitude * cos(y_sine/2);
x_sine = zeros(1, num_points_s);

pattern_points_s = [x_sine; y_sine; z_sine];
