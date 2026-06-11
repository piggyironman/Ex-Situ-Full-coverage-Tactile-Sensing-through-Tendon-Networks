function f = surface_point(x, r0, F, r, a, b)
    u = x(1);
    theta = x(2);
    lambda = x(3);

    c = [a*sin(u); b*(1 - cos(u)); 0];
    dc = [a*cos(u); b*sin(u); 0];
    t_hat = dc / norm(dc);

    if abs(dot(t_hat, [0;0;1])) < 0.99
        v = [0; 0; 1];
    else
        v = [0; 1; 0];
    end
    n1 = cross(t_hat, v); n1 = n1 / norm(n1);
    n2 = cross(t_hat, n1);

    S = c + r*(cos(theta) - 1)*n1 + r*sin(theta)*n2;

    f = r0 + lambda*F - S;
end
