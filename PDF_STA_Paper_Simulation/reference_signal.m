function r=reference_signal(t,P)
% Analytic [yd; dyd; ddyd; dddyd]; same trajectory as paper p.1822.
E=exp(-P.refDecay*t.^2); b=P.refDecay;
A=1-E; A1=2*b*t.*E; A2=(2*b-4*b^2*t.^2).*E;
A3=(-12*b^2*t+8*b^3*t.^3).*E;
r=P.refAmplitude*[sin(t).*A;cos(t).*A+sin(t).*A1; ...
 -sin(t).*A+2*cos(t).*A1+sin(t).*A2; ...
 -cos(t).*A-3*sin(t).*A1+3*cos(t).*A2+sin(t).*A3];
end
