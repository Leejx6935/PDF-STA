# PDF–STA 论文三阶系统仿真工程

本工程针对 Ding、Zhou、Shi 的论文第 V 节、式 (55) 的直流电机驱动单连杆机械臂。**当前是待 MATLAB/Simulink 验证的源代码交付；尚未成功复现图 5。** 请先阅读 `docs/验证记录.md`。原工作目录已有的“仿真文件”未修改。

## 使用入口

1. 在 MATLAB 中将本文件夹设为当前文件夹，运行 `para`。参数结构体 `P` 留在基础工作区。
2. 编辑 `para.m` 后重跑，以同步更新时滞、归一化积分等派生参数。修改 `P.T` 后只点运行仿真会使派生参数不一致。
3. MATLAB 数值入口为 `result=run_matlab_simulation(P)`，使用与 S-function 共用的方程核心。它会保存 MAT、指标和曲线。**显式 RK4 的直接 sign 版本在独立核查中未通过，不应将默认结果作为有效控制性能。**
4. 按 `docs/Simulink搭建说明.md` 手动搭建模型后，使用 `out=run_simulink('你的模型名',P)`。目前未交付 `.slx`。

## 文件分工

|文件|用途|
|---|---|
|para.m|所有默认物理、控制、观测、轨迹、扰动、数值参数|
|plant_rhs.m / sf_plant.m|真实物理对象，状态为位置、速度、电流|
|coordinate_map.m / sf_coordinates.m|式 (56)，将物理状态转换成误差坐标，计算 f、g|
|observer_rhs.m / sf_observer.m|式 (45)、(46)，三级 STA 扰动观测器|
|sta_gains.m|式 (14)–(16)，观测器变增益|
|controller_core.m / sf_controller.m|式 (49)–(51) 的三阶展开|
|pdf_kernel.m|周期时滞反馈核及解析导数|
|reference_signal.m / sf_reference.m|默认期望轨迹及一至三阶解析导数|
|disturbance_signal.m / sf_disturbance.m|独立的外加力矩扰动|
|analyze_results.m|误差、观测误差、控制峰值、能量和曲线|
|results/numerical_audit.py|辅助的独立方程核查；不能替代 MATLAB 执行|

所有 `sf_*.m` 均使用 **Level-2 MATLAB S-function** 的运行时对象与回调接口，不是 Level-1 的 flag 接口。不需要编译 MEX。时滞使用外部 Transport Delay，避免在 Outputs 中改写持久历史而破坏求解器回退。

主算例没有命令滤波器，因而未添加会改变论文结构的滤波模块。若后续加入滤波器，需要重新评估其相位滞后对预设时间结论的影响。

## 复现范围

已实现第 V 节三阶状态反馈分支；第 III、IV 节两类 STA 和第 VI 节二阶输出反馈分支在解析中说明，未声称已分别提供全部算例程序。噪声算例可按搭建说明插入噪声；原文未给出完整噪声功率、采样时间和随机种子，不能声称逐点复现图 6。

工程遵循已安装的 MathWorks 官方技能 `building-simulink-models`、`simulating-simulink-models` 的适用约定。官方建模接口在本会话不可用，未用脚本绕过它自动修改模型，采用用户允许的手动搭建交付。

来源：[论文 DOI](https://doi.org/10.1109/TAC.2025.3618707)、[MathWorks 技能目录](https://github.com/matlab/simulink-agentic-toolkit/blob/main/skills-catalog/README.md)、[Level-2 官方文档](https://www.mathworks.com/help/simulink/sfg/writing-level-2-matlab-s-functions.html)。核对日期：2026-10-31。
