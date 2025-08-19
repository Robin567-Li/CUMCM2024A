function [res] = fun3(d)
    res = 0;
    theta_tot = ones(224,1);
    for theta1 = 9*pi/d  %:100
        rho = (d/(2*pi))*theta1;
        theta_tot(1) = theta1; 
        theta_tot(2) = erfenfa_12(theta_tot(1),d);
        for i = 3:224
            theta_tot(i) = erfenfa_3(theta_tot(i-1),d);
        end
        p = (d/(2*pi));
        x1 = p*theta_tot(1)*cos(theta_tot(1));
        y1 = p*theta_tot(1)*sin(theta_tot(1));
        x2 = p*theta_tot(2)*cos(theta_tot(2));
        y2 = p*theta_tot(2)*sin(theta_tot(2));
        rect1_center = [(x1+x2)/2;(y1+y2)/2];
        k1 = (y2-y1)./(x2-x1);
        alpha1 = atan(k1);
        M1 = [cos(alpha1),-sin(alpha1);sin(alpha1),cos(alpha1)];
        rect1 = zeros(2,4);
        rect1(:,1) = rect1_center + M1*[3.41/2;0.15];
        rect1(:,2) = rect1_center + M1*[3.41/2;-0.15];
        rect1(:,3) = rect1_center + M1*[-3.41/2;-0.15];
        rect1(:,4) = rect1_center + M1*[-3.41/2;0.15];
        ((rect1(1,:)-x1).^2 + (rect1(2,:)-y1).^2).^(0.5);
        (0.275^2 + 0.15^2)^0.5;
        ((2.86+0.275)^2 + 0.15^2)^0.5;
        for i = 2:223 % 排除第二个
            x11 = p*theta_tot(i)*cos(theta_tot(i));
            y11 = p*theta_tot(i)*sin(theta_tot(i));
            x22 = p*theta_tot(i+1)*cos(theta_tot(i+1));
            y22 = p*theta_tot(i+1)*sin(theta_tot(i+1));
            k = (y22-y11)./(x22-x11);
            alpha = atan(k);
            M = [cos(alpha),-sin(alpha);sin(alpha),cos(alpha)];
            rect2_center = [(x11+x22)/2;(y11+y22)/2];
            rect2 = zeros(2,4);
            rect2(:,1) = rect2_center + M*[1.1;0.15];
            rect2(:,2) = rect2_center + M*[1.1;-0.15];
            rect2(:,3) = rect2_center + M*[-1.1;-0.15];
            rect2(:,4) = rect2_center + M*[-1.1;0.15];
            result = sat_rect_overlap(rect1',rect2');


            % plot([rect1(1,:),rect1(1,1)],[rect1(2,:),rect1(2,1)],"b")
            % hold on
            % plot(x1,y1,"b*")
            % plot(x2,y2,"b*")
            % plot([rect2(1,:),rect2(1,1)],[rect2(2,:),rect2(2,1)],"b")
            % % plot(rect2(1,:),rect2(2,:),"r*")
            % plot(x11,y11,"b*")
            % plot(x22,y22,"b*")
            % axis equal
    

            if result == true
                if i==2
                    continue
                end
                res = 1;
                fprintf("当d=%.12f,在theta=%.6f时，龙首刚好与第%d个龙身相撞\n",d,theta1,i)
                % break
            end
        end
    end
end