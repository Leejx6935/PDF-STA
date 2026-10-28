% 作者：OpenAI Codex；日期：2026-10-20；MATLAB R2025a。
% 参数脚本：运行后 P、n/m/p、各采样时间和 ref_data 落入当前工作区。
% 来源：用户手稿(1)--(94)及聊天中的 DSC 续推导；不是已认证实验配置。
% 同一台设备：保留 Yao2017 几何参数，以 Yang2021 补充名义参数。
% ode4：Fixed-step size = Ts_plant；不要把 Ts_plant 设为控制采样时间。

% === 系统结构参数 ===
P = struct;
P.n = 4; P.m = 1; P.p = 3;       % n/m/p：物理状态/输入/可测输出维数
P.ref_dim = 3;                    % [yd; yd_dot; yd_ddot]，单位 m,m/s,m/s^2
P.obs_bus_dim = 8;                % [xhat(4); dhat(4)]，详见 readme.txt
P.debug_dim = 32;                 % 控制器锁存调试向量维数
P.mass = 30;                      % m / 负载质量 / kg / 文献值
P.area = 904.778e-6;              % A / 有效面积 / m^2 / 文献值
P.vol0 = [3.98e-5;3.98e-5];       % V01,V02 / 单腔初始体积 / m^3 / Yao值
P.ps = 10e6; P.pr = 0.08e6;       % Ps,Pr / 供回油压力 / Pa / 文献值
P.b_true = 4000;                  % B / 名义黏性阻尼 / N*s/m / 文献名义值
P.af_true = 100;                  % Af / 摩擦幅值 / N / 仿真假设，待确认
P.beta_true = 7e8;                % beta_e / 体积弹性模量 / Pa / 文献名义值
P.ct_true = 4e-11;                % Ct / 内泄漏系数 / m^3/(s*Pa) / 文献值
P.kv_lumped = 1.18e-8;            % kv / 集中流量增益 / m^3/(s*V*sqrt(Pa))
P.ku_true = sqrt(2)*P.kv_lumped;  % ku / 双阀口增益 / 同上 / 模型换算假设
P.fric_slope = 900;               % S_f=2/pi*atan(900*v) / s/m / 文献形式
P.theta_true = [P.b_true;P.af_true;P.beta_true*P.ku_true; ...
                P.beta_true;P.beta_true*P.ct_true]; % 仅对象和离线诊断读取

% === 控制器参数 ===
P.k1 = 20; P.k2 = 40; P.k3 = 150; % k1,k2,k3 / 反馈增益 / 1/s / 待整定
P.h1 = 0.1; P.h2 = 0.1;          % h1,h2 / 反馈时延 / s / 待整定
P.tau_f = 0.015;                  % tau_f / 指令滤波时间常数 / s / 待整定
P.track_w = [1e3;100;1e-12];      % c1,c2,c3 / 能量权重 / J*/误差单位^2
P.obs_w = [1e3;1e-10];           % rho2,rho3 / 观测能量权重 / 待整定
P.gamma = [10;10;1e-3;1e12;1e-8];% Gamma对角元 / 参数单位^2/J* / 待整定
P.theta_min = [0;0;6;2e8;0];      % theta下界 / 各分量物理单位 / 待验证
P.theta_max = [1e4;1500;20;2e9;.1];% theta上界 / 同上 / 待验证
P.theta0 = [0;0;6.5;9e8;0];      % 参数估计初值 / 同上 / 可设置，待整定
% 不把这些初值当作真实设备参数；不复制文献控制器增益。

% === 观测器参数 ===
P.lambda1 = 80; P.lambda2 = 800;   % STA增益 / sqrt(m)/s,m/s^2 / 待整定
P.power_r = 3; P.power_p = (P.power_r-1)/P.power_r; % r,p / 无量纲
P.obs_k1 = [30;50];               % k21,k31 / 线性注入 / 1/s / 待整定
P.obs_k2 = [2;2000];              % k22,k32 / [e_i]^(1-p)/s / 待整定
P.obs_omega1 = [2500;2500];       % omega21,omega31 / 1/s^2 / 待整定
P.obs_omega2 = [20;20];           % omega22,omega32 / 1/s / 待整定
P.sign_eps = [1e-12;1e-12;1e-3]; % eo,e2,e3死区 / m,m/s,Pa / 数值近似

% === 扰动与参考 ===
% 理论只给扰动界，未规定波形。以下正弦族是可编辑仿真工况，不是新控制器。
P.dist_amp = [100;1e-7;1e-7];      % [dm;q1;q2]幅值 / N,m^3/s,m^3/s / 测试工况
P.dist_freq = [0.7;0.3;0.3];      % 频率 / Hz / 工程选择
P.dist_phase = [0;0;0];           % 相位 / rad / 工程选择
P.dist_delay = [1;2;2];           % 启动时刻 / s / 平滑开启，不用硬阶跃
P.dist_rise = [.2;.2;.2];         % 启动尺度 / s / 工程选择
% 若 q1,q2 只代表内泄漏修正，应设置相同波形以满足本稿符号下 q1=q2。
P.ref_amp = .010;                 % 参考峰值幅值 / m / 可设置
P.ref_freq = .5;                  % 参考频率 / Hz / 可设置
P.ref_rise = .2;                 % 平滑启动尺度 / s / 可设置
% yd=A*sin(2*pi*f*t)*(1-exp(-(t/tr)^4))，解析计算前3阶导数。

% === 饱和与安全限 ===
P.u_max = 10;                     % u_max(m x 1) / 电压 / V / 假设，待硬件确认
P.stroke_half = .044;             % 半行程 / m / 文献值
P.press_margin = .05e6;           % 压力检查裕量 / Pa / 工程选择
P.press_min = P.pr+P.press_margin;% 检查下界 / Pa / 非自动安全控制器
P.press_max = P.ps-P.press_margin;% 检查上界 / Pa / 同上
P.vol_min = 1e-6;                 % V_* / 体积检查下界 / m^3 / 待验证

% === 采样时间 ===
P.Ts_ctrl = 1e-4;                 % s；工程选择，非理论给出
P.Ts_obs = P.Ts_ctrl;             % s；本实现要求同步同速率
P.Ts_plant = P.Ts_ctrl/10;        % s；ode4固定步长/ode45最大步长
P.T_end = 6;                      % 仿真终止时间 / s / 参考3个周期
P.DEBUG = 1;                     % 0/1：只控制调试端口内容，不在S函数中画图打印
P.rel_tol = 1e-6; P.abs_tol = [1e-9;1e-8;1;1]; % ode45容差，按状态单位给定

% === 初值 ===
P.x0 = [-.005;0;5.04e6;5.04e6];  % [y;v;P1;P2] / m,m/s,Pa,Pa / 仿真假设
P.obs0 = [P.x0(1);0;0;P.x0(3)-P.x0(4);0;0;P.x0(3:4)];
% obs0=[xhat1;xhat2;zo2;zo3;etahat2;etahat3;P1_last;P2_last]
P.xi0 = P.x0(3)-P.x0(4);         % xi初值 / Pa；允许 ef(0) 非零
P.u0 = 0;                        % 初始锁存未饱和电压 / V

% === 理论假设、界与时间账本 ===
P.bounds.y_abs = .040;            % |y|界 / m / 待认证
P.bounds.v_abs = .5;              % |v|界 / m/s / 待认证
P.bounds.ev_abs = .5;             % |e_v|检查界 / m/s / 待认证
P.bounds.ref = [P.ref_amp;.5;20;2000]; % yd及前3阶导数界 / m,m/s,m/s^2,m/s^3
P.bounds.x0_abs = [.020;.1;9.9e6;9.9e6]; % 初始集合分量绝对值上界，另查压力下界
P.bounds.q_abs = P.dist_amp(2:3);  % 独立流量界 / m^3/s / 仅当前工况
P.bounds.d1 = P.dist_amp(1)/P.mass;% 加速度扰动界 / m/s^2
P.bounds.d2 = P.theta_max(4)*sum(P.bounds.q_abs)/P.vol_min; % Pa/s
P.bounds.dd1 = (2*pi*P.dist_freq(1)+2/P.dist_rise(1))*P.dist_amp(1)/P.mass; % m/s^3
P.bounds.dd2 = P.theta_max(4)*( ...
    sum((2*pi*P.dist_freq(2:3)+2./P.dist_rise(2:3)).*P.bounds.q_abs)/P.vol_min + ...
    P.area*P.bounds.v_abs*sum(P.bounds.q_abs)/P.vol_min^2); % Pa/s^2
P.bounds.La = P.area/P.mass*(P.press_max-P.press_min) + ...
    P.theta_max(1)/P.mass*P.bounds.v_abs + P.theta_max(2)/P.mass + P.bounds.d1;
P.time.T_goal = .4;               % 候选检查截止时间 / s / 非已证预设时间
P.time.T_ob = NaN;                % 集总观测器无已证独立固定截止时间
P.time.T_sta = NaN;               % 待由初始集合和STA常数认证，不能直接填0
P.time.T_pdf = 2*[P.h1;P.h2];      % 各约化周期层的时间，不等于全系统时间之和
P.time.T_filter = P.tau_f;         % 时间常数，不是有限收敛时间
P.cert.R = NaN; P.cert.VI = NaN; P.cert.VT = NaN; % 完整集合认证尚未完成
P.cert.LF = NaN; P.cert.Su = NaN;  % 需要独立认证，不能用观测到的峰值冒充先验界
P.lyap.filter_w = 1e-10;          % c_f / 滤波能量权重 / J*/Pa^2 / 分析待整定
P.lyap.sta_w = 1;                % rho_v / STA能量权重 / J*/(m/s)^2 / 待整定
P.lyap.press_w = 1e-14;           % c_P / 公共压力能量权重 / J*/Pa^2 / 待整定
P.lyap.mu = 1;                   % mu / 延迟积分衰减率 / 1/s / 分析待整定
P.lyap.delta_f = P.lyap.filter_w/(2*P.tau_f); % 分数幂Young参数，单位与对应能量项相容
P.lyap.delta_3 = P.track_w(3)*P.k3/2;
P.lyap.beta = P.obs_w.*P.obs_k1/2; % beta2,beta3 / Young参数 / 非物理扰动
P.lyap.scale = [.01;.1;1e6;.1;1e6;1;1e8;1e6]; % Z各分量归一化尺度

% === 派生缓存与工作区接口 ===
P.delay_steps = round([P.h1;P.h2]/P.Ts_ctrl);
P.hist_len = max(P.delay_steps)+1;
P.pdf_I = [integral(@(r)exp(2*P.k1*P.h1*r).*(r-1).^4.*(r-2).^4,1,2); ...
           integral(@(r)exp(2*P.k2*P.h2*r).*(r-1).^4.*(r-2).^4,1,2)];
hydro_core('validate',P);
n=P.n; m=P.m; p=P.p; u_max=P.u_max;
Ts_plant=P.Ts_plant; Ts_ctrl=P.Ts_ctrl; Ts_obs=P.Ts_obs; DEBUG=P.DEBUG;
t_ref=(0:P.Ts_ctrl:P.T_end).'; ref_data=zeros(numel(t_ref),4);
for ref_idx=1:numel(t_ref)
    ref_tmp=hydro_core('ref',t_ref(ref_idx),P);
    ref_data(ref_idx,:)=[t_ref(ref_idx),ref_tmp(1:3).'];
end
% From Workspace 使用 ref_data；三个S函数的参数栏均填写 P。
