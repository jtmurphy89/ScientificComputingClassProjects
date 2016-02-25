function [retval] = getdtBall (a, b, c, d)
r = 0.075;
% a = xb - xr
% b = ub - ur
% c = yb - yr
% d = vb - vr

retval = (sqrt(a^2+c^2)-2*r)/sqrt(b^2+c^2);

%retval = (-2*(a*b +c*d) + sqrt((2*(a*b+c*d)^2 - 4*(b^2 + d^2)*(a^2 + c^2 - 4*r^2))))/(2*(b^2 + d^2));

end 