clc,clear,close all

theta_list = [];
theta0 = 32*pi; 
dtheta_dt = @(t, theta) -40*pi./(11*sqrt(1 + theta.^2)); 
tspan = linspace(0, 420, 421);     
options = odeset('RelTol', 1e-9, 'AbsTol', 1e-9); 
[t, theta1] = ode45(dtheta_dt, tspan, theta0, options);       %   26.1465268090075

for i = 1:420
    theta0 = theta1(i); 
    dtheta_dt = @(t, theta) -40*pi./(11*sqrt(1 + theta.^2)); 
    tspan = linspace(0, 1, 100001);     
    options = odeset('RelTol', 1e-9, 'AbsTol', 1e-9); 
    [t, theta] = ode45(dtheta_dt, tspan, theta0, options);       %    26.146526312045
    theta_list = [theta_list;theta(1:end - 1)];
end



% theta_list = load("theta.mat");
% theta_list = theta_list.theta_list;
% theta_list(41247387) 
