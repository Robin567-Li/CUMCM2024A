function [theta9] = erfenfa_3(theta,d)

    youbian=@(x)(((2*pi)/d)^2)*1.65^2;  % 2.86  1.65
    zuobian=@(x)theta^2+x^2-2*theta*x*cos(-theta+x);
    a = theta;
    b = theta + pi;
    for ii = 1:220
        c = (a+b)/2;
        aa = youbian(a) - zuobian(a);
        cc = youbian(c) - zuobian(c);
        if aa*cc<0
            a = a;
            b = c;
        else
            a = c;
            b = b;
        end
    end
    theta9 = c; 
end