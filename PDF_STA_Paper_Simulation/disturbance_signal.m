function d=disturbance_signal(t,P)
% Plant-only torque disturbance. Never fed into controller/observer.
d=P.distAmplitude*sin(P.distOmega*t);
end
