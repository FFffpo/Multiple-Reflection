function Psy=sy(P,Line)

x0=P*[1 0]';
y0=P*[0 1]';
A=Line*[1 0 0]';
B=Line*[0 1 0]';
C=Line*[0 0 1]';

C1=B*x0-A*y0;
syms x y;
vars=[x,y];
eqns=[A*x+B*y+C==0,-B*x+A*y+C1==0];
[xp,yp]=solve(eqns,vars);

x1=2*xp-x0;
y1=2*yp-y0;

Psy=[x1 y1];
