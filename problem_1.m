clc,clear,close all

format long g

dtheta_dt = @(t, theta) -40*pi./(11*sqrt(1 + theta.^2)); 
theta0 = 32*pi;       
tspan = linspace(0, 300, 301);     
options = odeset('RelTol', 1e-9, 'AbsTol', 1e-9, 'Refine', 1); % 精度控制
[t, theta] = ode45(dtheta_dt, tspan, theta0, options);

l = [2.86, 1.65];
theta_matrix = zeros(224,length(tspan));

for i = 1:length(theta)
    theta_matrix(1,i) = theta(i); 
end

% n = ceil(6*log2(10) - log2(180-0));

for j = 1:length(tspan)
      theta_matrix(2,j) = erfenfa_12(theta_matrix(1,j),0.55);
end

for j = 1:length(tspan)
    for i = 3:224
      theta_matrix(i,j) = erfenfa_3(theta_matrix(i - 1,j),0.55); 
    end
end

rho_matrix = (11/(40*pi)) .* theta_matrix;

result_matrix = zeros(448,length(tspan));
for i = 1:size(rho_matrix,1)
    x = rho_matrix(i,:).*cos(theta_matrix(i,:));
    y = rho_matrix(i,:).*sin(theta_matrix(i,:));
    result_matrix(2*i-1,:) = x;
    result_matrix(2*i,:) = y;
end

result_matrix = round(result_matrix, 6);
writematrix(result_matrix,'result1.xlsx','Sheet','位置','Range','B2:KP449')

V=ones (224,length(tspan));

for j = 1:length(tspan)
    for i=1:223
         u=theta_matrix(i,j); 
         v=theta_matrix(i+1,j); 
         G = (u*v*sin(v-u)+v*cos(v-u)-u)/(u*v*sin(v-u)-u*cos(v-u)+v); 
         V(i+1,j) = V(i,j)*abs(G)*sqrt((1+v^2)/(1+u^2));
    end 
end

V = round(V, 6);
writematrix(V,'result1.xlsx','Sheet','速度','Range','B2:KP225')

for i = 1:length(tspan)  
    x = rho_matrix(:,i).*cos(theta_matrix(:,i));
    y = rho_matrix(:,i).*sin(theta_matrix(:,i));
    plot(x,y,"b-") 
    grid on
    pause(0.0005)
    axis equal
end

title("title")
xlabel("x")
ylabel("y")


% for i = 410:413  
%     x = rho_matrix(:,i).*cos(theta_matrix(:,i));
%     y = rho_matrix(:,i).*sin(theta_matrix(:,i));
%     plot(x,y,"b-")
%     grid on
%     pause(0.1)
%     axis equal
% end
 % 经过动画演示，可知应在第410-415秒之间相撞，且撞到第9个（第八个龙身）








