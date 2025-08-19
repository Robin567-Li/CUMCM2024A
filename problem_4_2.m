clc,clear,close all

format long g


% 从开始计时来看，在第1330.0425491秒时，龙头进入圈内
% 所求-100-0秒，即第1230.0425491-1330.0425491秒
%对应rho是 31.8617426274912-16.6319611072401


dtheta_dt = @(t, theta) (-2*pi/1.7)/sqrt(1 + theta.^2); 
theta0 = 31.8617426274912;       
tspan = linspace(0, 100, 101);     
options = odeset('RelTol', 1e-9, 'AbsTol', 1e-9, 'Refine', 1); % 精度控制
[t, theta] = ode45(dtheta_dt, tspan, theta0, options);


l = [2.86, 1.65];
theta_matrix = zeros(224,length(tspan));

for i = 1:length(theta)
    theta_matrix(1,i) = theta(i); 
end

% n = ceil(6*log2(10) - log2(180-0));

for j = 1:length(tspan)
      theta_matrix(2,j) = erfenfa_12(theta_matrix(1,j),1.7);
end

for j = 1:length(tspan)
    for i = 3:224
      theta_matrix(i,j) = erfenfa_3(theta_matrix(i - 1,j),1.7); 
    end
end

rho_matrix = (1.7/(2*pi)) .* theta_matrix;

result_matrix = zeros(448,length(tspan));
for i = 1:size(rho_matrix,1)
    x = rho_matrix(i,:).*cos(theta_matrix(i,:));
    y = rho_matrix(i,:).*sin(theta_matrix(i,:));
    result_matrix(2*i-1,:) = x;
    result_matrix(2*i,:) = y;
end

result_matrix = round(result_matrix, 6);
writematrix(result_matrix,'result4.xlsx','Sheet','位置','Range','B2:CX449')

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
writematrix(V,'result4.xlsx','Sheet','速度','Range','B2:CX225')

for i = 1:length(tspan)  
    x = rho_matrix(:,i).*cos(theta_matrix(:,i));
    y = rho_matrix(:,i).*sin(theta_matrix(:,i));
    plot(x,y,"b")
    grid on
    pause(0.0005)
    axis equal
end
hold on

plot(rho_matrix(1,length(tspan)).*cos(theta_matrix(1,length(tspan))),rho_matrix(1,length(tspan)).*sin(theta_matrix(1,length(tspan))),"b*")
x_circle = 4.5*cos(linspace(0,2*pi,100)); 
y_circle = 4.5*sin(linspace(0,2*pi,100)); 
plot(x_circle, y_circle, 'r');
axis equal







