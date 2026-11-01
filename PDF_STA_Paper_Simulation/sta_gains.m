function gain=sta_gains(t,delayed,i,P)
% delayed=[e_i(t-hob); D_i(t-hob)], equations (14)-(16).
a=P.obsA; b=P.obsB; c=P.obsC; d1=P.delta1(i); d2=P.delta2(i);
ev=eig([a b;b c]); lm=min(ev); lM=max(ev);
gamma0=-b*sqrt(lm)/(2*lM);
vbar=P.l4*d1+d2;
l3=(b^2+2*a^2+4*b^2*vbar+4*c^2*vbar^2)/(4*(a*c-b^2));
l1=(a-2*c*l3)/b; l2=2*P.l4;
e=delayed(1); D=delayed(2); den=sqrt(2*D^2+e^2+2*d1^2+1);
W1=sqrt(lM)*den;
W2=sqrt(lM)*(-l1*abs(e)^1.5-l2*e^2+e*D+abs(e)*d1 ...
 +2*l3*abs(D)-2*P.l4*D^2+2*abs(D)*0)/den;
if t>=2*i*P.hob
 K=0; Kd=0;
else
 [K,Kd]=pdf_kernel(t,P.hob,P.l4,P.Wob,'sin');
end
k4=P.l4+2*(K*W2+Kd*W1)/(2*K*W1+gamma0);
delta=abs(k4)*d1+d2;
k3=(b^2+2*a^2+4*b^2*delta+4*c^2*delta^2)/(4*(a*c-b^2));
gain=[(a-2*c*k3)/b;2*k4;k3;k4];
end
