# 手动搭建与接口

先运行根目录 `para.m`，确保根目录及 `sfunctions` 已加入 MATLAB 路径。新建空白模型，可保存为本文件夹中的 `paper_sta.slx`。每个自定义模块使用 **Level-2 MATLAB S-Function** 模块（不是 S-Function Builder，也不是旧版 Level-1 S-Function）；S-function name 不带 `.m`，Parameters 都填 `P`。

## 顶层子系统

|子系统名|内部模块/函数|输入|输出|
|---|---|---|---|
|Reference（期望信号）|sf_reference，或自建信号模块|无|r，4 维|
|Disturbance（扰动）|sf_disturbance，或自建信号模块|无|d，标量|
|Plant（被控对象）|sf_plant|1: u，2: d|x，3 维|
|Coordinates（坐标变换）|sf_coordinates|1: x，2: r|1: xi(3)，2: f，3: g|
|Observer（观测器）|sf_observer|1: xi(3)，2: fu，3: od(6)|1: zh(3)，2: D(3)，3: ho(6)|
|Controller（控制器）|sf_controller|1: zh(3)，2: D(3)，3: f，4: g，5: cd(6)|1: u，2: hc(6)|

另放 Product 和 Sum 组成 `fu=f+g*u`，反馈给 Observer 输入 2。Plant 输出直接接 Coordinates 输入 1；Reference 接 Coordinates 输入 2。Coordinates 的 xi 接 Observer 输入 1；f、g 接 Controller 对应端口。Observer 的 zh、D 接 Controller；Controller 的 u 接 Plant，并分支进入 `f+g*u`。

## 两条时滞支路，不能省略

1. Observer 输出 3 `ho` → Transport Delay（Time delay=`P.hob`，Initial output=`zeros(6,1)`）→ Observer 输入 3 `od`。
2. Controller 输出 2 `hc` → Transport Delay（Time delay=`P.hc`，Initial output=`zeros(6,1)`）→ Controller 输入 5 `cd`。

`ho=[e1;D1;e2;D2;e3;D3]`，其中 `e=xi-[0;D1;D2]-zh`。`hc=[zh1;zh2;zh3;s10;s11;s20]`。两者都是列向量；不要交叉连接两条时滞。

默认 `P.hob=0.5 s`、`P.hc=2 s`。Transport Delay 用真实时间延迟，不以 Memory 替代。缓冲区应允许自动增长；固定步长要显著小于最短时滞。

Observer 的输出 zh、D 仅依赖连续状态；输出 ho 还依赖 xi，因此代码对 xi 标为直接馈通。`fu` 仅进入状态导数，不读取它计算输出。这一分工避免人为构造 u→Observer 输出→u 的代数环。

## 在子系统中自定义期望轨迹

Reference 的外部接口固定为 `[yd; dyd; ddyd; dddyd]`。可删除内部默认 S-function，用正弦、斜坡、MATLAB Function 或 Signal Editor 构造轨迹，再用 Mux 按该顺序组装。推荐直接提供解析导数；连续 Derivative 串联三次会放大噪声。

轨迹至少三阶光滑；阶跃位置轨迹不满足本控制律的导数要求。若要跟踪分段轨迹，先用具有连续前三阶导数的过渡曲线连接。默认轨迹为 `(pi/2)*sin(t)*(1-exp(-0.1*t^2))`。

## 自定义扰动与噪声

Disturbance 仅输出外加力矩 `DeltaI`，默认 `0.3*sin(t)`。它只接 Plant 输入 2，绝不接控制器或观测器。修改扰动后检查其导数上界是否仍由 `P.delta1`、`P.delta2` 覆盖；不连续阶跃不满足相同定理条件。

如需噪声实验，在 Plant 与 Coordinates 之间加入 3 维加法器。论文用同一个标量噪声加到 q、dq、I，可复制同一噪声到三个通道。真实对象反馈仍用内部状态，记录时保留真实 x 和测量 xm。自行记录噪声源功率、采样时间、种子。当前 MATLAB 纯数值入口未加入噪声。

## 求解器与记录

手动试验可先使用变步长 ode15s、相对容差 `1e-6`、绝对容差 `1e-8`、最大步长 `1e-4`；这些是待实测的数值起点，并非已通过设置。Level-2 MATLAB S-function 在 Normal 模式运行；先不要使用 Accelerator。

`run_simulink` 默认用于固定步长 ode4 对照，并非已验证的推荐求解器；变步长试验请在模型中手动运行，或修改该文件的 SimulationInput 设置。不要以曲线看起来平滑代替步长/容差收敛检查。

开启信号日志，给 x、r、xi、zh、D、u 命名；保存 logsout。先做模型更新（Ctrl+D），处理所有维数与未连接端口问题，再仿真。核查：没有代数环、两条延迟均为正数、所有块参数均是 P。

应比较 T=15 s 后的跟踪最大误差和 RMS、Tob=3 s 后的观测最大误差、输入峰值、输入平方积分，以及步长/容差变化后的差异。`xi3` 本身不要求归零：真实 `z3=xi3+DeltaI/M`；应按后者计算观测误差。
