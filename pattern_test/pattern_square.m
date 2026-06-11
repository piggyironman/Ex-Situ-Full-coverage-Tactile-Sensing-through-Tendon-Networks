square_size = 12;
y_start = 4;
y_end = 20;
num_squares = 1;
num_points_per_side = 25;

num_points_square = 4 * num_points_per_side * num_squares;

y_sq = zeros(1, num_points_square);
z_sq = zeros(1, num_points_square);

for s = 1:num_squares
    center_y = y_start + (s-0.5)*(y_end-y_start)/num_squares;

    side_range = (s-1)*4*num_points_per_side + 1 : s*4*num_points_per_side;

    y_sq(side_range(1:num_points_per_side)) = center_y + square_size/2 * ones(1,num_points_per_side);
    z_sq(side_range(1:num_points_per_side)) = linspace(-square_size/2, square_size/2, num_points_per_side);

    y_sq(side_range(num_points_per_side+1:2*num_points_per_side)) = linspace(center_y+square_size/2, center_y-square_size/2, num_points_per_side);
    z_sq(side_range(num_points_per_side+1:2*num_points_per_side)) = square_size/2 * ones(1,num_points_per_side);

    y_sq(side_range(2*num_points_per_side+1:3*num_points_per_side)) = center_y - square_size/2 * ones(1,num_points_per_side);
    z_sq(side_range(2*num_points_per_side+1:3*num_points_per_side)) = linspace(square_size/2, -square_size/2, num_points_per_side);

    y_sq(side_range(3*num_points_per_side+1:4*num_points_per_side)) = linspace(center_y-square_size/2, center_y+square_size/2, num_points_per_side);
    z_sq(side_range(3*num_points_per_side+1:4*num_points_per_side)) = -square_size/2 * ones(1,num_points_per_side);
end

x_sq = zeros(1, num_points_square);

pattern_points_square = [x_sq; y_sq; z_sq];
