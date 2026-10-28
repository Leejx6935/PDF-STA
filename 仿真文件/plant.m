function plant(block)
% 作者：OpenAI Codex；2026-10-20；MATLAB R2025a Level-2 M-file S-Function。
% 原手稿(1)--(8)；连续4状态。ode4固定步长<=Ts_ctrl/10，默认P.Ts_plant。
% 输入1 u_applied(1)：外部饱和后的实际电压[V]。
% 输入2 d_in(3)=[dm(N);q1(m^3/s);q2(m^3/s)]，来自外部扰动Subsystem。
% 输出1 y(3)=[位置m;P1 Pa;P2 Pa]；输出2 x_full(4)，仅离线调试。
% 参数栏填写P。实验控制不可读取x_full；本文件不实现硬件I/O。
% 实现对照表：公式编号 | 对应代码 | 备注
% (1),(4),(5),(8) | hydro_core.m:63 (local_plant) | 连续Derivatives，无对象降阶
% (7)扰动 | local_dist | 外部3维输入；不叠加内部扰动
% 幅值饱和 | hydro_core.m:63 (local_plant) | 防御性限幅；仍须外接Saturation
local_setup(block);
end
function local_setup(block)
block.NumDialogPrms=1;block.DialogPrmsTunable={'Nontunable'};
P=block.DialogPrm(1).Data;hydro_core('validate',P);
block.NumInputPorts=2;block.NumOutputPorts=2;
block.SetPreCompInpPortInfoToDynamic;block.SetPreCompOutPortInfoToDynamic;
block.InputPort(1).Dimensions=P.m;block.InputPort(1).DatatypeID=0;
block.InputPort(1).Complexity='Real';block.InputPort(1).DirectFeedthrough=false;
block.InputPort(2).Dimensions=3;block.InputPort(2).DatatypeID=0;
block.InputPort(2).Complexity='Real';block.InputPort(2).DirectFeedthrough=false;
for j=1:2
    block.OutputPort(j).DatatypeID=0;block.OutputPort(j).Complexity='Real';
end
block.OutputPort(1).Dimensions=P.p;block.OutputPort(2).Dimensions=P.n;
block.NumContStates=P.n;block.SampleTimes=[0 0];
block.SimStateCompliance='DefaultSimState';
block.RegBlockMethod('InitializeConditions',@local_init);
block.RegBlockMethod('Outputs',@local_outputs);
block.RegBlockMethod('Derivatives',@local_derivatives);
end
function local_init(block)
P=block.DialogPrm(1).Data;block.ContStates.Data=P.x0;
end
function local_outputs(block)
x=block.ContStates.Data;
block.OutputPort(1).Data=x([1,3,4]);block.OutputPort(2).Data=x;
end
function local_derivatives(block)
P=block.DialogPrm(1).Data;x=block.ContStates.Data;t=block.CurrentTime;
d=local_dist(t,x,P,block.InputPort(2).Data);
block.Derivatives.Data=hydro_core('plant_rhs',t,x,block.InputPort(1).Data,P,d);
end
function d=local_dist(~,~,~,d_in)
% 只接收外部扰动，禁止与内部波形重复叠加。
assert(numel(d_in)==3 && all(isfinite(d_in)),'扰动输入必须为有限3维向量。');
d=d_in(:);
end
