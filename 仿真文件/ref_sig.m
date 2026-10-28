function [reference,jerk] = ref_sig(t,amp,freq,rise)
% 参考子系统MATLAB Function代码；2026-10-20。
% 输入：Clock时间t[s]；amp[m]；freq[Hz]；启动尺度rise[s]。
% 输出1：[yd;yd_dot;yd_ddot]；输出2：yd_dddot，仅诊断，可接Terminator。
% 三个Constant依次填写P.ref_amp、P.ref_freq、P.ref_rise。
w=2*pi*freq;g=exp(-(t/rise)^4);
if g==0
    b=1;bd=0;bdd=0;bddd=0;
else
    b=1-g;bd=4*t^3/rise^4*g;
    bdd=(12*t^2/rise^4-16*t^6/rise^8)*g;
    bddd=(24*t/rise^4-144*t^5/rise^8+64*t^9/rise^12)*g;
end
s=sin(w*t);c=cos(w*t);
reference=amp*[s*b;w*c*b+s*bd;-w^2*s*b+2*w*c*bd+s*bdd];
jerk=amp*(-w^3*c*b-3*w^2*s*bd+3*w*c*bdd+s*bddd);
end
