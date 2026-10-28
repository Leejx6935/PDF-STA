# 外部信号子系统与总接线

本次没有启动 MATLAB、没有建立 slx、没有运行闭环仿真。以下参数是工程测试工况。

## 参考子系统

设 b(t)=1-exp[-(t/0.2)^4]，参考为 yd(t)=0.01*b(t)*sin(pi*t)，单位 m。
输出为 [yd; yd_dot; yd_ddot]，均采用解析表达式，不使用Derivative块。

搭建 Clock + 3个Constant -> MATLAB Function（粘贴 ref_sig.m） -> Outport。

| MATLAB Function输入 | Constant值 | 单位 |
|---|---|---|
| t | Clock | s |
| amp | P.ref_amp = 0.01 | m |
| freq | P.ref_freq = 0.5 | Hz |
| rise | P.ref_rise = 0.2 | s |

函数输出reference为3维列向量，接ctrl输入2；第二输出jerk接Terminator。
启动尺度0.2s不是0.2s时包络已到1；约0.4s时已十分接近1。
稳态幅值10mm、周期2s；默认仿真6s。

## 扰动子系统

每通道 tau_j=t-delay_j，在 tau_j<=0 时输出0；否则
d_j=amp_j*(1-exp[-(tau_j/rise_j)^4])*sin(2*pi*freq_j*tau_j+phase_j)。

搭建 Clock + 5个3维Constant -> MATLAB Function（粘贴 dist_sig.m） -> Outport。

| 输入 | Constant值 |
|---|---|
| t | Clock |
| amp | P.dist_amp = [100;1e-7;1e-7] |
| freq | P.dist_freq = [0.7;0.3;0.3] |
| phase | P.dist_phase = [0;0;0] |
| delay | P.dist_delay = [1;2;2] |
| rise | P.dist_rise = [0.2;0.2;0.2] |

输出 d=[dm;q1;q2]，单位分别为 N、m^3/s、m^3/s，接新版plant输入2。
第二输出dd仅供导数诊断，先接Terminator。

dm在机械方程中以+dm出现。q1在第一腔方程中以+q1出现，q2在第二腔方程中以-q2出现。
因此同一波形q1=q2形成相反方向的腔内流量作用，不是同时向两腔净注油。
1e-7m^3/s=0.006L/min，是小幅等效守恒流量测试，不代表实测或被动泄漏定律。

## 误差不是外部注入信号

误差监测用两个Selector取 plant输出1的第1项和 reference的第1项。
Sum块符号设为+-，先接实际y，再接yd，得到 z1=y-yd。
单位m；若用Gain=1000显示mm，误差界为+-1.76mm。
ctrl输入1仍接[y;P1;P2]，不能改接误差，否则会重复减参考。

## 更新说明

plant已改为两个输入；原版本备份在 backup_internal_disturbance。
plant只使用外部扰动，不叠加内部波形。check调用相同dist_sig函数以保持默认工况一致。
core调用ref_sig和dist_sig，因此新增两个m文件必须保留在路径中，即便已将代码粘入Subsystem。
如果自行修改Subsystem中的公式，请同步修改对应m文件或停止用check对照该工况。

总接线图见 Simulink_wiring.png / Simulink_wiring.svg。
所有准确端口编号见readme.txt。
