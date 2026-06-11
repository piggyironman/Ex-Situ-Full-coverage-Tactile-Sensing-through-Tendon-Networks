function R = my_rotation(axis, theta)

    switch lower(axis)
        case 'x'
            R = [1, 0, 0;
                0, cos(theta), -sin(theta);
                0, sin(theta), cos(theta)];
        case 'y'
            R = [cos(theta), 0, sin(theta);
                0, 1, 0;
                -sin(theta), 0, cos(theta)];
        case 'z'
            R = [cos(theta), -sin(theta), 0;
                sin(theta), cos(theta), 0;
                0, 0, 1];
        otherwise
            error('Invalid axis. Use ''x'', ''y'', or ''z''.');
    end
end
