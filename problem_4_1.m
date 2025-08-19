clc,clear,close all

hold on
d = 1.7;
theta1 = 9*pi/d;
rho = (d/(2*pi))*theta1;
xa = rho*cos(theta1) ;  %  -2.71185586370666  √
ya = rho*sin(theta1) ;  %   -3.59107752276107  √
alpha = atan( -( (d/(2*pi))*cos(theta1) - rho*sin(theta1) )/( (d/(2*pi))*sin(theta1) + rho*cos(theta1) ) )
k = tan(alpha);     
xb = -rho*cos(theta1) ;  %   2.71185586370666  √
yb = -rho*sin(theta1)  ; %   3.59107752276107  √
% dd = ((xb-xa)^2 + (yb - ya)^2)^0.5


xq = xa + (2/3)*(xb - xa); %  0.903951954568886  √
yq = ya + (2/3)*(yb - ya) ; %  1.19702584092036  √
alpha0 = atan((yb-ya)./(xb-xa))
k0 = tan(alpha0);
alpha1 = alpha0 - alpha  ;  % 弧度制，角度制为3.44077805009858   √
r1 = 3/cos(alpha1)  ; %  3.00541766778904   √
r2 = r1/2       ;     %  1.50270883389452   √
x_circle1 = xa + r1*cos(alpha)   %  -0.760009116655529   下面四个有误差
y_circle1 = ya + r1*sin(alpha)   %  -1.30572642634626
x_circle2 = xb - r2*cos(alpha)   %  1.73593249018109
y_circle2 = yb - r2*sin(alpha)   %   2.44840197455367

s = r1*(pi - 2*alpha1) + r2*(pi - 2*alpha1);   % 13.6212449068211  √
x = linspace(-3,3,100);

x_circle = 4.5*cos(linspace(0,2*pi,100)); 
y_circle = 4.5*sin(linspace(0,2*pi,100)); 
plot(x_circle, y_circle, 'b');
plot([xa,xa+4*cos(alpha)],[ya,ya+4*sin(alpha)],"b-")
plot([xb,xb-2*cos(alpha)],[yb,yb-2*sin(alpha)],"b-")
plot([xq+2*cos(alpha0+alpha1),xq-4*cos(alpha0+alpha1)],[yq+2*sin(alpha0+alpha1),yq-4*sin(alpha0+alpha1)],"b")
plot([xa,xb],[ya,yb],"b-")
plot(xa,ya,"b*")
plot(xb,yb,"b*")
plot(xq,yq,"b*")
plot(x_circle1,y_circle1,"r*")
plot(x_circle2,y_circle2,"r*")
axis equal


