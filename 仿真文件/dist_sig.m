function [d,dd] = dist_sig(t,amp,freq,phase,delay,rise)
% 扰动子系统MATLAB Function代码；2026-10-20。
% 除t[s]外，其余输入都是固定3x1向量；Constant填写P.dist_*。
% 输出d=[dm(N);q1(m^3/s);q2(m^3/s)]；dd为时间导数，仅诊断。
% q1进入第一腔，q2以负号进入第二腔；本推荐q1=q2。
d=zeros(3,1);dd=zeros(3,1);
for j=1:3
    tau=t-delay(j);
    if tau<=0,continue;end
    g=exp(-(tau/rise(j))^4);b=1-g;
    if g==0,bd=0;else,bd=4*tau^3/rise(j)^4*g;end
    w=2*pi*freq(j);arg=w*tau+phase(j);
    d(j)=amp(j)*b*sin(arg);
    dd(j)=amp(j)*(bd*sin(arg)+b*w*cos(arg));
end
end
