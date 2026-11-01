function [u,history]=controller_core(t,zh,D,f,g,delayed,P)
% Exact n=3 expansion of (49)-(51), no numerical differentiation.
% delayed=[s00;s01;s02;s10;s11;s20](t-hc).
[K,Kd,Kdd]=pdf_kernel(t-P.Tob,P.hc,P.a,P.Wc,'poly');
z1=zh(1); z2=zh(2); z3=zh(3);
s10=z2+P.a*z1+K*delayed(1);
s11=z3+P.a*z2+K*delayed(2)+Kd*delayed(1);
s20=s11+P.a*s10+K*delayed(4);
tail1=P.a*z3+K*delayed(3)+2*Kd*delayed(2)+Kdd*delayed(1);
tail2=P.a*s11+K*delayed(5)+Kd*delayed(4);
u=(-K*delayed(6)-P.a*s20-f+D(3)-tail1-tail2)/g;
history=[z1;z2;z3;s10;s11;s20];
end
