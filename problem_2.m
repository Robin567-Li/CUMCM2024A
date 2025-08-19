clc,clear,close all

format long g    % 26.352603633422080    25.915795186647780    0-420
                 % 26.352604039865460    25.915795468562592    0-412

a = 26;   %  26.3-26.8
b = 40;
for ii = 1:20000
    
    c = (a+b)/2;
    aa = slove_d(a,0.55) - 0.15;
    cc = slove_d(c,0.55) - 0.15;
    if aa*cc<0
       a = a;
       b = c;
    else
       a = c;
       b = b;
    end
end
res = c;

dtheta_dt = @(t, theta) -40*pi./(11*sqrt(1 + theta.^2)); 
theta0 = 32*pi;     
tspan = linspace(0, 420, 421);    %   0-420s 
options = odeset('RelTol', 1e-9, 'AbsTol', 1e-9, 'Refine', 1); %   精度控制
[t,theta] = ode45(dtheta_dt, tspan, theta0, options);

theta0 = theta(413)            %   第412秒
tspan = linspace(0, 1, 100001);     
options = odeset('RelTol', 1e-9, 'AbsTol', 1e-9); 
[t, theta] = ode45(dtheta_dt, tspan, theta0, options);       %   26.146526312045
[i,j] = min(abs(theta - res)); 
tot_time = t(j) + 412         %   412.4738598 
res_theta = theta(j)

theta_tot = ones(224,1);
theta_tot(1) = theta(j); 
theta_tot(2) = erfenfa_12(theta_tot(1),0.55);
for i = 3:224
    theta_tot(i) = erfenfa_3(theta_tot(i-1),0.55);
end

V = ones(224,1);
for i=1:223
         u=theta_tot(i); 
         v=theta_tot(i+1); 
         G = (u*v*sin(v-u)+v*cos(v-u)-u)/(u*v*sin(v-u)-u*cos(v-u)+v); 
         V(i+1) = V(i)*abs(G)*sqrt((1+v^2)/(1+u^2));
end 

x = (11/(40*pi)).*theta_tot.*cos(theta_tot);
y = (11/(40*pi)).*theta_tot.*sin(theta_tot);
plot(x,y)
hold on 
xx = [(11/(40*pi))*26.1465965779221*cos(26.14659657792212), 
    (11/(40*pi))*26.1465965779221*sin(26.1465965779221)];
plot(xx(1),xx(2),"r*")

title("title")
xlabel("x")
ylabel("y")

result = [x,y,V];
result = round(result, 6);
writematrix(result,'result2.xlsx','Range','B2:D225')


