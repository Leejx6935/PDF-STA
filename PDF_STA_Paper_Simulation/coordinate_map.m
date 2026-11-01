function [xi,f,g]=coordinate_map(x,r,P)
% Equation (56). x may be the measured state including measurement noise.
q=x(1); v=x(2); I=x(3);
xi=[q-r(1);v-r(2);(-P.B*v-P.N*sin(q)+I)/P.M-r(3)];
f=-P.N*cos(q)*v/P.M-P.R*I/(P.L*P.M)-P.KB*v/(P.L*P.M) ...
 -r(4)+P.B^2*v/P.M^2+P.B*P.N*sin(q)/P.M^2-P.B*I/P.M^2;
g=1/(P.L*P.M);
end
