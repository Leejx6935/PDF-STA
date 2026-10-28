function varargout = hydro_core(action,varargin)
% 作者：OpenAI Codex；2026-10-20；R2025a；共享纯MATLAB内核，不依赖Simulink。
% 原稿(1),(14),(38),(42),(78),(83),(88)；续式U1滤波、U2电压、U3参数律。
% 数字状态均前向欧拉；控制输出锁存一拍；积分用矩形累加。
% 此函数没有 persistent/global；S函数缓存全部由其Dwork传入传出。
switch action
    case 'validate', local_validate(varargin{1});
    case 'ref', varargout{1}=local_ref(varargin{:});
    case 'plant_rhs', varargout{1}=local_plant(varargin{:});
    case 'ctrl_init'
        P=varargin{1}; varargout{1}=[P.theta0;P.xi0;P.u0;0;zeros(32+4*P.hist_len,1)];
    case 'obs_init', varargout{1}=varargin{1}.obs0;
    case 'ctrl_step', varargout{1}=local_ctrl(varargin{:});
    case 'obs_step', varargout{1}=local_obs(varargin{:});
    case 'ctrl_out'
        s=varargin{1}; P=varargin{2}; varargout{1}=s(7);
        varargout{2}=s(9:40)*double(P.DEBUG); varargout{3}=s(1:5);
    case 'obs_out'
        s=varargin{1}; varargout{1}=s([1,2,7,8]);varargout{2}=s([5,6,3,4]);
    case 'dist', [varargout{1:nargout}]=local_dist(varargin{:});
    case 'reg', [varargout{1:nargout}]=local_reg(varargin{:});
    case 'sat', varargout{1}=local_sat(varargin{:});
    otherwise, error('Hydro:Action','未知内核动作：%s',action);
end
end

function local_validate(P)
assert(P.n==4 && P.m==1 && P.p==3,'本理论要求 n=4,m=1,p=3。');
assert(P.ref_dim==3 && P.obs_bus_dim==8 && P.debug_dim==32,'端口维数配置错误。');
assert(all([P.mass;P.area;P.vol0;P.ps-P.pr;P.ku_true;P.beta_true]>0),'物理参数必须为正。');
assert(P.b_true>=0 && P.af_true>=0 && P.ct_true>=0,'阻尼、摩擦幅值和泄漏不能为负。');
assert(isequal(size(P.u_max),[P.m,1]) && all(P.u_max>0),'u_max必须为正的m列向量。');
assert(P.Ts_ctrl>0 && P.Ts_obs>0 && P.Ts_plant>0,'采样时间必须为正。');
assert(abs(P.Ts_obs-P.Ts_ctrl)<1e-12,'此同步实现要求Ts_obs=Ts_ctrl。');
assert(P.Ts_plant<=P.Ts_ctrl/10*(1+1e-12),'对象最大步长须不超过Ts_ctrl/10。');
assert(all([P.k1;P.k2;P.k3;P.h1;P.h2;P.tau_f;P.track_w;P.obs_w; ...
    P.gamma;P.lambda1;P.lambda2;P.obs_k1;P.obs_k2;P.obs_omega1;P.obs_omega2]>0),'所有增益和时间参数必须为正。');
assert(P.power_r>2 && abs(P.power_p-(P.power_r-1)/P.power_r)<1e-12,'分数幂参数不符理论。');
assert(all(isfinite(P.sign_eps)) && all(P.sign_eps>=0),'符号死区必须非负有限。');
assert(all(P.theta_min<=P.theta0) && all(P.theta0<=P.theta_max) && P.theta_min(3)>0,'参数初值或正输入增益下界非法。');
assert(all(P.theta_true>=P.theta_min) && all(P.theta_true<=P.theta_max),'真实参数不在假设盒内。');
assert(all(abs([P.h1;P.h2]/P.Ts_ctrl-P.delay_steps)<1e-9),'时延须为Ts_ctrl整数倍；禁止静默取整。');
assert(P.hist_len==max(P.delay_steps)+1 && all(P.delay_steps>=1),'环形缓存长度错误。');
assert(all(isfinite(P.pdf_I)) && all(P.pdf_I>0) && max([P.k1*P.h1,P.k2*P.h2])<100,'PDF积分非法或指数尺度过大。');
assert(numel(P.x0)==4 && numel(P.obs0)==8 && all(isfinite([P.x0;P.obs0;P.theta0])),'初值维数或有限性错误。');
assert(P.press_min>P.pr && P.press_max<P.ps && P.press_min<P.press_max,'压力检查域非法。');
assert(all(P.x0(3:4)>P.pr) && all(P.x0(3:4)<P.ps),'初始腔压不在物理域内。');
assert(P.ref_rise>0 && P.ref_freq>=0 && P.ref_amp>=0 && P.T_end>0,'参考/时长参数非法。');
assert(all(P.dist_amp>=0) && all(P.dist_freq>=0),'扰动幅值和频率须非负。');
assert(numel(P.dist_delay)==3 && numel(P.dist_rise)==3 && ...
    all(P.dist_delay>=0) && all(P.dist_rise>0),'扰动启动参数须为合法3维向量。');
end

function r=local_ref(t,P)
[reference,jerk]=ref_sig(t,P.ref_amp,P.ref_freq,P.ref_rise);
r=[reference;jerk];
end

function [d,dd]=local_dist(t,~,P)
[d,dd]=dist_sig(t,P.dist_amp,P.dist_freq,P.dist_phase,P.dist_delay,P.dist_rise);
end

function dx=local_plant(t,x,u,P,d)
% 原式(1)：真实物理对象。只使用真实参数；不读取控制器内部状态。
u=local_sat(u,P.u_max); % 防御性限幅；外部实际电压仍必须同时回传ctrl/obs。
V=[P.vol0(1)+P.area*x(1);P.vol0(2)-P.area*x(1)];
local_domain(x([1,3,4]),P,sprintf('plant t=%.12g s, u=%.9g V, v=%.9g m/s',t,u,x(2)));
g=local_gain(x(3),x(4),u,P);if nargin<5,d=local_dist(t,x,P);end
pl=x(3)-x(4);
Q=P.ku_true*g*u;sf=2/pi*atan(P.fric_slope*x(2));
dx=[x(2);(P.area*pl-P.b_true*x(2)-P.af_true*sf+d(1))/P.mass; ...
    P.beta_true/V(1)*(Q(1)-P.area*x(2)-P.ct_true*pl+d(2)); ...
    P.beta_true/V(2)*(P.area*x(2)-Q(2)+P.ct_true*pl-d(3))];
end

function sn=local_obs(s,y,u,theta,P)
% 原式(14),(38),(42)：所有右端都用同一旧状态；不调用隐式STA。
local_domain(y,P,'observer measurement');[phi2,phi3]=local_reg(y,s(2),u,P);
eo=s(1)-y(1);e2=s(2)-s(3);e3=y(2)-y(3)-s(4);
sg=local_sat_sign(eo,P.sign_eps(1));
q=[local_sig(e2,P.power_p,P.sign_eps(2));local_sig(e3,P.power_p,P.sign_eps(3))];
e=[e2;e3];uo=s(5:6)+P.obs_k1.*e+P.obs_k2.*q;
ds=[s(2)-P.lambda1*sqrt(abs(eo))*sg; -P.lambda2*sg; ...
    P.area/P.mass*(y(2)-y(3))+phi2.'*theta+uo(1); ...
    phi3.'*theta+uo(2);P.obs_omega1.*e-P.obs_omega2.*s(5:6)];
sn=[s(1:6)+P.Ts_obs*ds;y(2:3)]; % 后两通道是测量锁存，不是压力观测器
end

function sn=local_ctrl(s,t,y,ref,bus,u_actual,P)
% 原式(78),(83),(88)及续式U1/U2/U3；本函数不对输出电压做sat。
local_domain(y,P,sprintf('controller t=%.12g s',t));assert(numel(bus)==8 && numel(ref)==3,'控制器输入向量维数错误。');
theta=s(1:5);xi=s(6);tick=round(s(8));N=P.hist_len;
hist=reshape(s(41:end),4,N);vh=bus(2);nhat=bus(5:6);zo=bus(7:8);
[K1,dK1]=local_kernel(t,P.k1,P.h1,P.pdf_I(1));
[K2,~]=local_kernel(t,P.k2,P.h2,P.pdf_I(2));
z1=y(1)-ref(1);z1d=0;z2d=0;vhd=0;rd=0;
if tick>=P.delay_steps(1)
    j=mod(tick-P.delay_steps(1),N)+1;z1d=hist(1,j);vhd=hist(3,j);rd=hist(4,j);
end
if tick>=P.delay_steps(2)
    j=mod(tick-P.delay_steps(2),N)+1;z2d=hist(2,j);
end
alpha1=ref(2)-P.k1*z1-K1*z1d;z2=vh-alpha1;
D1=ref(3)-P.k1*(vh-ref(2))-dK1*z1d-K1*(vhd-rd);
e=[vh-zo(1);y(2)-y(3)-zo(2)];
q=[local_sig(e(1),P.power_p,P.sign_eps(2));local_sig(e(2),P.power_p,P.sign_eps(3))];
uo=nhat+P.obs_k1.*e+P.obs_k2.*q;
[phi2,phi3,phv,php]=local_reg(y,vh,u_actual,P);a=P.area/P.mass;
alpha2=(D1-phi2.'*theta-uo(1)-P.k2*z2-K2*z2d)/a;
z3=y(2)-y(3)-xi;ef=xi-alpha2;dxi=-ef/P.tau_f;
chi=ef-P.obs_k2(1)/a*q(1);
nu=dxi+theta(4)*phv+theta(5)*php-uo(2)-P.k3*z3 ...
    -(P.track_w(2)/P.track_w(3))*a*z2;
g=local_gain(y(2),y(3),nu,P);V=[P.vol0(1)+P.area*y(1);P.vol0(2)-P.area*y(1)];
gain=sum(g./V);assert(theta(3)>0 && gain>0,'阀电压反演分母非正。');
uc=nu/(theta(3)*gain);
tau=(P.track_w(2)*z2+P.obs_w(1)*e(1))*phi2 ...
    +(P.track_w(3)*z3+P.obs_w(2)*e(2))*phi3;
dtheta=P.gamma.*tau;
mask=(theta<=P.theta_min & dtheta<0)|(theta>=P.theta_max & dtheta>0);
dtheta(mask)=0;
theta_next=min(max(theta+P.Ts_ctrl*dtheta,P.theta_min),P.theta_max);
% 离散投影保持盒约束，但不能把连续投影不等式原样当作离散定理。
j=mod(tick,N)+1;hist(:,j)=[z1;z2;vh;ref(2)];
[~,oldphi3]=local_reg(y,vh,s(7),P);
su=theta(3)*(phi3(3)-oldphi3(3)); % 已施加电压相对旧锁存命令的饱和诊断
dbg=[t;z1;z2;z3;ef;chi;alpha1;alpha2;xi;D1;K1;K2;dK1; ...
    e;uo;nu;uc;u_actual;u_actual-s(7);dxi;z1d;z2d;vhd;j;dtheta;su];
sn=[theta_next;xi+P.Ts_ctrl*dxi;uc;tick+1;dbg;hist(:)];
assert(all(isfinite(sn)),'控制器出现NaN/Inf，请检查增益、步长和压力工作域。');
end

function [phi2,phi3,phv,php]=local_reg(y,vh,u,P)
V=[P.vol0(1)+P.area*y(1);P.vol0(2)-P.area*y(1)];
g=local_gain(y(2),y(3),u,P);phu=sum(g./V);
phv=P.area*vh*sum(1./V);php=(y(2)-y(3))*sum(1./V);
phi2=[-vh/P.mass;-2/pi*atan(P.fric_slope*vh)/P.mass;0;0;0];
phi3=[0;0;phu*u;-phv;-php];
end

function g=local_gain(p1,p2,u,P)
% 不把负根号截成0；物理域失效立即报错，不能继续冒充原模型。
assert(p1>P.pr && p1<P.ps && p2>P.pr && p2<P.ps,'压力越出阀口根号物理域。');
if u>=0,g=[sqrt(P.ps-p1);sqrt(p2-P.pr)];
else,g=[sqrt(p1-P.pr);sqrt(P.ps-p2)];end
end

function local_domain(y,P,context)
% 诊断信息可能来自求解器内部试算点，不一定是已接受的输出采样点。
if nargin<3,context='measurement';end
V=[P.vol0(1)+P.area*y(1);P.vol0(2)-P.area*y(1)];
if ~all(isfinite(y)) || ~all(V>0)
    error('Hydro:VolumeDomain', ...
        '%s: 测量非有限或体积非正。y=%.9g m, V1=%.9g, V2=%.9g m^3。', ...
        context,y(1),V(1),V(2));
end
if ~all(y(2:3)>P.pr) || ~all(y(2:3)<P.ps)
    error('Hydro:PressureDomain', ...
        ['%s: 压力超出本模型工作域。P1=%.9g MPa, P2=%.9g MPa; ' ...
        '要求 %.9g < P1,P2 < %.9g MPa。y=%.9g m。' ...
        '该值可能是求解器内部试算点；请同时检查停止前的压力和控制电压波形。'], ...
        context,y(2)/1e6,y(3)/1e6,P.pr/1e6,P.ps/1e6,y(1));
end
end

function [K,dK]=local_kernel(t,k,h,I)
% 原式(75)--(77)：用无量纲r=sigma/h计算，h^8在归一化中消去。
r=mod(t,2*h)/h;
if r<1,K=0;dK=0;return;end
R=(r-1)^4*(r-2)^4;Rp=4*(r-1)^3*(r-2)^3*(2*r-3);
E=exp(-k*h+2*k*h*r)/I;
K=E*R/h;dK=E*(Rp+2*k*h*R)/h^2;
end

function s=local_sat_sign(x,e)
if abs(x)<e || x==0,s=0;else,s=sign(x);end
end
function z=local_sig(x,p,e)
z=abs(x)^p*local_sat_sign(x,e);
end
function u=local_sat(u,lim)
u=min(max(u,-lim),lim);
end
