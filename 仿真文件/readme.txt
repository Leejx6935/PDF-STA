液压DSC仿真文件；MATLAB R2025a；2026-10-20；作者 OpenAI Codex

更新：plant现在有2个输入；输入2接外部扰动子系统的[dm;q1;q2]。
新增ref_sig.m、dist_sig.m，可将函数内容粘贴到MATLAB Function块中。
两个辅助函数的第二输出只用于导数诊断，可接Terminator，不接控制器。
1. 范围与运行
使用本聊天最后一版理论，而不是模板中尚未粘贴的新推导。
保留原稿(1),(14),(38),(42),(78),(83),(88)，续式定义如下：
U1: tau_f*xi_dot=alpha2-xi；ef=xi-alpha2；chi=ef+( -k22/a*sig^p(e2))。
U2: nu=xi_dot+theta4hat*phivhat+theta5hat*phip-uo3-k3*z3-(c2/c3)*a*z2。
U3: theta_dot=Proj(Gamma*((c2*z2+rho2*e2)*phi2hat+(c3*z3+rho3*e3)*phi3hat))。
新z3=x3-xi；本稿没有额外滑模面s或影子延迟差分观测器，不能凭空增加。
没有生成slx，没有电流/PWM内环，没有新增压力过滤器或积分冻结。
将本目录加入路径，运行para。三个Level-2 MATLAB S-Function参数栏均填P。
运行check执行纯MATLAB数字闭环自检，调用ode45，不需要Simulink。
check可能较慢，因为每一个控制周期都重新调用ode45以严格保持输入。
hydro_core.m是必要的共享内核，避免S函数与check实现不同控制律。
本次只做源代码人工审阅；MATLAB启动器曾报错，随后按用户要求不再启动。
未执行check，未在MATLAB或Simulink中编译/运行；不能声称已通过运行验证。
不修改MATLAB安装。若本机已有同名自定义函数，加入路径前用which -all检查。

2. 参数与单位
P.n=4: [y m;v m/s;P1 Pa;P2 Pa]；P.m=1: 电压V；P.p=3: [y;P1;P2]。
设备基准：m=30kg，A=904.778e-6m^2，V01=V02=3.98e-5m^3，半行程44mm。
Ps=10MPa，Pr=0.08MPa；B=4000 N*s/m，beta=7e8Pa，Ct=4e-11 m^3/(s*Pa)。
ku=sqrt(2)*1.18e-8为对称集中流量模型转换候选值，不是论文直接测得ku。
Af=100N、u_max=10V、初始状态、扰动波形、参考、所有控制增益均有待确认/整定。
当前扰动幅值为[100N;1e-7m^3/s;1e-7m^3/s]，启动时刻[1;2;2]s。
所有扰动采用0.2s尺度的平滑包络，参数是测试工况，不是设备已测扰动。
若扰动仅为内部泄漏修正，按当前符号保持q1=q2，不任意独立注入。
P.theta_true仅对象和离线诊断读取；控制器和观测器不读取真实参数/速度/扰动。
可编辑参数集中在para.m的P字段；便捷别名n/m/p/Ts等只是脚本输出。
编辑h或Ts后重新运行para以更新缓存长度与PDF归一化积分。

3. 固定端口表
模块 | 端口 | 信号 | 维度 | 单位/说明
plant | 输入1 | u_applied | 1 | V，外部饱和后的实际值
plant | 输入2 | d_in | 3 | [dm N;q1 m^3/s;q2 m^3/s]，只使用外部输入
plant | 输出1 | y_meas | 3 | [m;Pa;Pa]
plant | 输出2 | x_full | 4 | [m;m/s;Pa;Pa]，仅离线调试
obs | 输入1 | y_meas | 3 | [m;Pa;Pa]
obs | 输入2 | u_applied | 1 | V，禁止接未饱和命令
obs | 输入3 | theta_hat | 5 | 必需参数回传，来自ctrl输出3
obs | 输出1 | xhat | 4 | [xhat1 m;xhat2 m/s;P1_last Pa;P2_last Pa]
obs | 输出2 | dhat | 4 | [etahat2 m/s^2;etahat3 Pa/s;zo2 m/s;zo3 Pa]
ctrl | 输入1 | y_meas | 3 | [m;Pa;Pa]
ctrl | 输入2 | reference | 3 | [yd m;yd_dot m/s;yd_ddot m/s^2]
ctrl | 输入3 | observer_bus | 8 | Mux([obs输出1;obs输出2])，顺序不能变
ctrl | 输入4 | u_applied | 1 | V，实际输入回传及抗饱和诊断接口
ctrl | 输出1 | u_unsat | 1 | V，不在ctrl内限幅
ctrl | 输出2 | debug | 32 | 下列次序，P.DEBUG=0时全0
ctrl | 输出3 | theta_hat | 5 | 估计参数，回传obs输入3

debug次序：1时间，2 z1，3 z2，4 z3，5 ef，6 chi，7 alpha1，8 alpha2，9 xi，
10 D1，11 K1，12 K2，13 K1_dot，14 e2，15 e3，16 uo2，17 uo3，18 nu，
19新计算uc，20实际u，21实际u减旧命令，22 xi_dot，23 z1延迟，24 z2延迟，
25估计速度延迟，26环形槽号，27:31参数导数，32旧命令的饱和残差估计。
量纲依次遵循原公式。调试向量也是一拍锁存的，时间字段是计算时刻。

4. 接线顺序（Normal仿真模式）
自建Reference子系统：Clock+3个Constant进入ref_sig，输出reference(3) -> ctrl输入2。
三个Constant依次为P.ref_amp、P.ref_freq、P.ref_rise；jerk接Terminator。
也可仍用From Workspace(ref_data，插值关闭，采样时间Ts_ctrl)，两种来源任选其一。
自建Disturbance子系统：Clock+5个3维Constant进入dist_sig，输出d(3) -> plant输入2。
五个Constant依次为P.dist_amp、P.dist_freq、P.dist_phase、P.dist_delay、P.dist_rise。
dist_sig第二输出dd接Terminator；禁止将扰动再加到电压或位置测量上。
Stop time=P.T_end（默认6s）；禁止参考数据结束后继续外推。
ctrl输出1 -> Saturation(上限P.u_max，下限-P.u_max) -> plant输入1。
该Saturation输出同时分支到obs输入2、ctrl输入4以及电压Scope。
plant输出1分别连接ctrl输入1与obs输入1。
ctrl输出3连接obs输入3。
obs输出1、输出2按顺序Mux成8维，连接ctrl输入3。
plant输出2仅接调试/误差Scope；不要接入ctrl或obs。
ctrl输出2接Scope；需要时用Selector按debug表取分量。
三个模块均使用Simulink的Level-2 MATLAB S-Function块，名称填plant/ctrl/obs。
不得选择旧的Level-1接口。参数均填P。无须额外Unit Delay。

5. 求解器与调度
Type: Fixed-step；Solver: ode4；Fixed-step size: P.Ts_plant。
本版Ts_obs=Ts_ctrl=1e-4s，是工程选择，非理论给出；默认步长1e-5s。
Outputs只读取Dwork，输入不直接馈通。Update读取同一旧采样快照。
u[k]由前一次Update计算，在[t_k,t_(k+1))保持；u[0]=P.u0。
theta和observer输出也锁存。check以同一旧快照计算所有新状态后再统一提交。
xi、STA、影子系统、etahat和参数均前向欧拉，积分为矩形累加。
参数另作离散盒投影；不存在隐式STA、精确指数滤波或隐藏的积分冻结。
延迟h/Ts必须是整数，否则中文报错。历史由ctrl的Dwork环形数组保存。
首个半周期K=0，负时间历史无需测量；读缓存前先检查足够采样数。

6. 时间账本与理论状态
STA: Tv<=2*sqrt(Vo(0))/co，仅连续、无噪声、加速度界成立时。
集总观测器：本联合证明未给独立固定T_ob，不用旧dot(eta)假设冒充已证。
周期层：2*h1、2*h2分别为理想约化/有界受迫层时间，不可直接相加当总时间。
滤波器：tau_f为时间常数，非有限收敛时间。
P.time.T_goal是候选测试指标，不是经过证明的截止时间。
用户2%指标按满行程88mm计算，即位置误差+/-1.76mm。
仅在已认证初始集合、工作域、增益及能量条件下才能使用连续理论截止时间结论。
P.cert中的NaN明确表示未认证，不影响进行探索性数值仿真。

7. 检查与局限
check打印实际限幅、NaN/Inf、位置误差、收敛时间、压力/体积/初值/参数/扰动界。
收敛时间是有限记录中最后一次越界之后的时刻，不代表无限未来保证。
对象用四状态积分。负根号/非正体积不截断掩盖，错误时停止。
check压力裕量事件会提前终止；Simulink可用同样裕量加Assertion/Stop Simulation。
plant内防御性限幅不能替代外部Saturation，否则实际u回传会不一致。
抗饱和回灌只参与实际输入回归和诊断，未添加新控制器。若需要冻结须修改理论。
符号死区、显式离散、一拍锁存和离散投影均引入理论之外的数值残差。
因此不能直接把理想STA精确有限时间结论或连续Lyapunov证明用于本数字实现。
压力公共模态全时间不变性与完整增益可行性仍待验证；数值检查不是理论证明。
未默认加入噪声或阀动态，因为它们没有在当前理论对象中定义。
进入实验前须确认ku换算、Af、电压限幅、扰动物理关系、采样能力与实际保护。
说明：当前q1=q2的正弦族是等效守恒流量测试，不宣称它就是被动内泄漏定律。
plant不再调用内部波形，也不叠加P.dist_*；纯MATLAB的check则调用相同dist_sig波形。
