function [K,Kd,Kdd]=pdf_kernel(t,h,k,W,kind)
% Equations (8),(9): exponent uses phase t within EACH 2h period.
if t<0, K=0; Kd=0; Kdd=0; return; end
v=mod(t,2*h);
if v<=h, K=0; Kd=0; Kdd=0; return; end
if strcmp(kind,'sin')
 R=sin(pi*v/h)^2; Rd=pi/h*sin(2*pi*v/h); Rdd=2*(pi/h)^2*cos(2*pi*v/h);
else
 % R=(v-h)^4(v-2h)^4, C^3 at switching boundaries.
 p=v-h; q=v-2*h;
 R=p^4*q^4; Rd=4*p^3*q^4+4*p^4*q^3;
 Rdd=12*p^2*q^4+32*p^3*q^3+12*p^4*q^2;
end
E=exp(-k*(h-2*v))/W;
K=E*R; Kd=E*(Rd+2*k*R); Kdd=E*(Rdd+4*k*Rd+4*k^2*R);
end
