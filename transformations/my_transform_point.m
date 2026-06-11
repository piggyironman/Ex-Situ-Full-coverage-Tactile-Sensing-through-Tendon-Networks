function transformed_point = my_transform_point(T, point)

    if size(point, 1) == 3
        transformed_point = T(1:3, 1:3) * point + T(1:3, 4);
    else
        error('Input point must be a 3-by-1 vector');
    end
end
