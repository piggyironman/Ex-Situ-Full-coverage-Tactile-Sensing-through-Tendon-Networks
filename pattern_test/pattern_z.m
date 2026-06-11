z_height = 4;
y_start = 3;
y_end = 110 - 29*pi;
num_segments = 3;
num_points_z = 100;

y_z = linspace(y_start, y_end, num_points_z);
z_z = zeros(1, num_points_z);

points_per_segment = ceil(num_points_z / num_segments);

for z = 1:num_segments
    seg_start = (z-1)*points_per_segment + 1;
    seg_end = min(z*points_per_segment, num_points_z);
    if mod(z,2) == 1
        z_z(seg_start:seg_end) = linspace(-z_height, z_height, seg_end-seg_start+1);
    else
        z_z(seg_start:seg_end) = linspace(z_height, -z_height, seg_end-seg_start+1);
    end
end
x_z = zeros(1, num_points_z);

pattern_points_z = [x_z; y_z; z_z];
