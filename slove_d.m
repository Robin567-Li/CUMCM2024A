function [d] = slove_d(theta1,d)
        theta_1_10 = ones(10,1);
        theta_1_10(2) = erfenfa_12(theta1,0.55);
        for i = 3:10  % 5-20
            theta_1_10(i) = erfenfa_3(theta_1_10(i-1),0.55);
        end
        theta2 = theta_1_10(2);
        theta9 = theta_1_10(9);
        theta10 = theta_1_10(10);
        d2 = 0.275;
        d1 = 0.15;
        u9t = (11/(40*pi)).*theta9*cos(theta9);  %  撞9
        v9t = (11/(40*pi)).*theta9*sin(theta9);
        k = (theta10*sin(theta10)-theta9*sin(theta9)) ./ (theta10*cos(theta10)-theta9*cos(theta9));
        k1 = ((11/(40*pi))*theta2*sin(theta2) - (11/(40*pi))*theta1*sin(theta1) )./( (11/(40*pi))*theta2 ...
            *cos(theta2) - (11/(40*pi))*theta1*cos(theta1));
        xa1 = (11/(40*pi))*theta1*cos(theta1) + d2*cos(atan(k1)) - d1*sin(atan(k1));
        ya1 = (11/(40*pi))*theta1*sin(theta1) + d2*sin(atan(k1)) + d1*cos(atan(k1));

        d = abs(k*(xa1-u9t)-ya1+v9t) ./ sqrt(1+k^2) ;  %  0.15

end