function check_equations(P)
% Local algebra and normalization checks; not a full closed-loop acceptance.
for kind={'sin','poly'}
 if strcmp(kind{1},'sin'), h=P.hob; k=P.l4; W=P.Wob;
 else, h=P.hc; k=P.a; W=P.Wc; end
 val=integral(@(t) arrayfun(@(s) pdf_kernel(s,h,k,W,kind{1}),t),h,2*h);
 assert(abs(exp(k*h)*val-1)<1e-7,'PDF normalization mismatch.');
 t=1.4*h; epsT=1e-5*h;
 [K,Kd,Kdd]=pdf_kernel(t,h,k,W,kind{1});
 Kp=pdf_kernel(t+epsT,h,k,W,kind{1}); Km=pdf_kernel(t-epsT,h,k,W,kind{1});
 assert(abs((Kp-Km)/(2*epsT)-Kd)<1e-5*(1+abs(Kd)));
 assert(abs((Kp-2*K+Km)/epsT^2-Kdd)<1e-3*(1+abs(Kdd)));
end
disp('Kernel normalization and analytic derivatives passed. Closed loop remains unverified.');
end
