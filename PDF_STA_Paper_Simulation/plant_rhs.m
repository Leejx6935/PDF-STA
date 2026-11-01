function dx=plant_rhs(x,u,d,P)
% Physical model (55), not error-coordinate surrogate.
dx=[x(2);(-P.B*x(2)-P.N*sin(x(1))+x(3)+d)/P.M; ...
 (u-P.R*x(3)-P.KB*x(2))/P.L];
end
